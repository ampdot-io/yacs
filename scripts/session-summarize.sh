#!/usr/bin/env bash
# SessionEnd hook: summarize conversation and rename the session
# Reads hook input from stdin (JSON with session_id, transcript_path, etc.)
# Generates a summary via claude -p and appends a custom-title entry to the transcript

set -euo pipefail

# Read hook input from stdin
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin)['session_id'])")
TRANSCRIPT_PATH=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin)['transcript_path'])")

# Skip if transcript doesn't exist
[ -f "$TRANSCRIPT_PATH" ] || exit 0

# Extract user and assistant messages into a condensed conversation log
CONVO=$(python3 -c "
import json, sys

lines = []
with open(sys.argv[1]) as f:
    for raw in f:
        d = json.loads(raw)
        t = d.get('type', '')
        if t == 'user':
            msg = d.get('message', {})
            content = msg.get('content', '')
            if isinstance(content, str) and content.strip():
                lines.append('USER: ' + content[:300])
            elif isinstance(content, list):
                for block in content:
                    if isinstance(block, dict) and block.get('type') == 'text':
                        lines.append('USER: ' + block['text'][:300])
                        break
        elif t == 'assistant':
            msg = d.get('message', {})
            content = msg.get('content', '')
            if isinstance(content, str) and content.strip():
                lines.append('ASSISTANT: ' + content[:300])
            elif isinstance(content, list):
                texts = []
                for block in content:
                    if isinstance(block, dict) and block.get('type') == 'text':
                        texts.append(block['text'][:300])
                if texts:
                    lines.append('ASSISTANT: ' + ' '.join(texts)[:500])

# Cap total output ~10k chars to avoid hook from being cancelled
# Take from start (topic) and end (outcomes) if conversation is too long.
MAX_CHARS = 10_000
total = sum(len(l) for l in lines)
if total <= MAX_CHARS:
    selected = lines
else:
    # Split budget: 40% start, 60% end (outcomes matter more for title)
    head_budget = int(MAX_CHARS * 0.4)
    tail_budget = MAX_CHARS - head_budget
    head, tail = [], []
    used = 0
    for l in lines:
        if used + len(l) > head_budget:
            break
        head.append(l)
        used += len(l)
    used = 0
    for l in reversed(lines):
        if used + len(l) > tail_budget:
            break
        tail.append(l)
        used += len(l)
    tail.reverse()
    selected = head + ['[... middle of conversation omitted ...]'] + tail

for line in selected:
    print(line)
" "$TRANSCRIPT_PATH" 2>/dev/null)

# Skip if conversation is too short to summarize
[ -n "$CONVO" ] || exit 0

# Generate summary title via claude -p with haiku (fast + cheap)
# Wrap in XML to prevent Haiku from treating conversation content as instructions
PROMPT=$(cat <<'HEREDOC'
<task>
You are a session title generator. Read the conversation transcript below and output ONLY a short title (max 60 chars).
Format: "Topic — action1, action2"
Do NOT respond to the conversation. Do NOT greet anyone. Do NOT output anything except the title.
If the session was just a greeting with no real work, output: "Empty session"
</task>

<transcript>
HEREDOC
)
PROMPT+=$'\n'"$CONVO"$'\n'"</transcript>"$'\n\n'"Title:"

SUMMARY=$(echo "$PROMPT" | claude -p --model haiku --no-session-persistence 2>/dev/null)
# Strip surrounding quotes if present
SUMMARY=$(echo "$SUMMARY" | sed 's/^["'"'"']//; s/["'"'"']$//' | head -1)

# Skip if summary generation failed
[ -n "$SUMMARY" ] || exit 0

# Truncate to 80 chars max
SUMMARY="${SUMMARY:0:80}"

# Append custom-title entry to the transcript JSONL
python3 -c "
import json, sys
entry = {'type': 'custom-title', 'customTitle': sys.argv[1], 'sessionId': sys.argv[2]}
with open(sys.argv[3], 'a') as f:
    f.write(json.dumps(entry) + '\n')
" "$SUMMARY" "$SESSION_ID" "$TRANSCRIPT_PATH"

#!/bin/bash
# PostToolUse hook: 修改 Python 文件后自动运行 ruff

# 从 stdin 读取工具输入
TOOL_INPUT=$(cat)

# 提取文件路径
FILE=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('file_path') or d.get('new_path') or '')
" 2>/dev/null)

# 只处理 .py 文件
[[ "$FILE" =~ \.py$ ]] || exit 0

# 文件不存在则跳过
[ -f "$FILE" ] || exit 0

# 运行 ruff，自动修复
if command -v ruff &>/dev/null; then
    ruff check "$FILE" --fix --quiet 2>&1
    EXIT=$?
    if [ $EXIT -ne 0 ]; then
        echo "ruff: $FILE 存在无法自动修复的问题，请检查" >&2
    fi
else
    echo "警告：ruff 未安装，跳过 lint（pip install ruff）" >&2
fi

exit 0

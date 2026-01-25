#!/usr/bin/env bash

set -euo pipefail

echo "=== Claude Code Setup Script ==="
echo ""

# 1. Check if Claude Code is already installed
if command -v claude &> /dev/null; then
    echo "  ✓ Claude Code is already installed"
    echo ""
    echo "Current version:"
    claude --version 2>/dev/null || echo "  (version info unavailable)"
    echo ""
else
    # 2. Install Claude Code
    echo "Installing Claude Code..."
    echo ""

    if curl -fsSL https://claude.ai/install.sh | bash; then
        echo ""
        echo "  ✓ Claude Code installed successfully"
        echo ""

        # Try to get version info
        if command -v claude &> /dev/null; then
            echo "========================================"
            echo "Claude Code Version:"
            echo "========================================"
            claude --version 2>/dev/null || echo "  (version info unavailable)"
            echo "========================================"
        fi
    else
        echo ""
        echo "✗ Claude Code installation failed"
        echo ""
        echo "Please check your internet connection and try again."
        echo "You can also install manually by running:"
        echo "  curl -fsSL https://claude.ai/install.sh | bash"
        exit 1
    fi
fi

# 3. Add PATH to .zshrc
echo ""
echo "Setting up PATH configuration..."

ZSHRC="$HOME/.zshrc"

if ! grep -q "Claude Code" "$ZSHRC"; then
    echo "Adding Claude Code PATH to .zshrc..."

    if grep -q "Load aliases from alias directory" "$ZSHRC"; then
        LINE_NUM=$(grep -n "Load aliases from alias directory" "$ZSHRC" | cut -d: -f1)

        if [ -n "$LINE_NUM" ]; then
            # 해당 라인 앞까지 자르기
            head -n "$((LINE_NUM - 1))" "$ZSHRC" > /tmp/zshrc_new.tmp

            # Claude Code PATH 추가
            {
                echo ""
                echo "# Claude Code"
                echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
            } >> /tmp/zshrc_new.tmp

            # 나머지 내용 추가 (Load aliases 라인부터)
            tail -n +"$LINE_NUM" "$ZSHRC" >> /tmp/zshrc_new.tmp

            mv /tmp/zshrc_new.tmp "$ZSHRC"
        fi
    else
        # XDG alias 로딩이 없으면 맨 아래 추가
        {
            echo ""
            echo "# Claude Code"
            echo "export PATH=\"$HOME/.local/bin:\$PATH\""
        } >> "$ZSHRC"
    fi

    echo "  ✓ Claude Code PATH added to .zshrc"
else
    echo "  ✓ Claude Code PATH already exists in .zshrc"
fi

echo ""
echo "✓ Claude Code setup complete!"
echo ""
echo "터미널을 다시 시작하거나 다음 명령어로 설정을 적용하세요:"
echo "  source ~/.zshrc"
echo ""
echo "To get started, run:"
echo "  claude"
echo ""
echo "For more information, visit:"
echo "  https://claude.ai/claude-code"
echo ""

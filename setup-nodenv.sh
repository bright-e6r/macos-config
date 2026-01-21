#!/bin/bash

set -e

echo "=== Nodenv Setup Script ==="
echo ""

# 1. nodenv 설치 확인
if ! command -v nodenv &> /dev/null; then
    echo "✗ nodenv not found. Please run install.sh first to install nodenv via Homebrew."
    exit 1
fi

# 2. .zshrc에 nodenv 설정 추가
echo "Setting up nodenv configuration..."

ZSHRC="$HOME/.zshrc"

if ! grep -q "Nodenv: Node.js version management" "$ZSHRC"; then
    echo "Adding nodenv configuration to .zshrc..."

    if grep -q "Load aliases from alias directory" "$ZSHRC"; then
        LINE_NUM=$(grep -n "Load aliases from alias directory" "$ZSHRC" | cut -d: -f1)

        if [ -n "$LINE_NUM" ]; then
            # 해당 라인 앞까지 자르기
            head -n "$((LINE_NUM - 1))" "$ZSHRC" > /tmp/zshrc_new.tmp

            # nodenv 설정 추가
            {
                echo ""
                echo "# Nodenv: Node.js version management"
                echo "export NODENV_ROOT=\"\$HOME/.nodenv\""
                echo "export PATH=\"\$NODENV_ROOT/bin:\$PATH\""
                echo "eval \"\$(nodenv init -)\""
            } >> /tmp/zshrc_new.tmp

            # 나머지 내용 추가 (Load aliases 라인부터)
            tail -n +"$LINE_NUM" "$ZSHRC" >> /tmp/zshrc_new.tmp

            mv /tmp/zshrc_new.tmp "$ZSHRC"
        fi
    else
        # XDG alias 로딩이 없으면 맨 아래 추가
        {
            echo "# Nodenv: Node.js version management"
            echo "export NODENV_ROOT=\"$HOME/.nodenv\""
            echo "export PATH=\"$NODENV_ROOT/bin:$PATH\""
            echo "eval \"\$(nodenv init -)\""
        } >> "$ZSHRC"
    fi

    echo "  ✓ Nodenv configuration added to .zshrc"
else
    echo "  ✓ Nodenv configuration already exists in .zshrc"
fi

echo ""

# 3. 최신 LTS 버전 감지
echo "Detecting latest LTS version..."
VERSIONS=$(nodenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V)
LATEST_LTS=$(echo "$VERSIONS" | grep -E '^22\.' | tail -1)

if [ -z "$LATEST_LTS" ]; then
    # 22.x가 없으면 20.x에서 찾기
    LATEST_LTS=$(echo "$VERSIONS" | grep -E '^20\.' | tail -1)
fi

echo "  Latest LTS: $LATEST_LTS"

# 4. Node.js 설치 여부 확인 및 설치
if [ ! -d "$HOME/.nodenv/versions/$LATEST_LTS" ]; then
    echo ""
    echo "Installing Node.js $LATEST_LTS..."

    # Node.js 설치 (에러 처리 포함)
    if nodenv install "$LATEST_LTS"; then
        echo "  ✓ Node.js $LATEST_LTS installed successfully"
        nodenv global "$LATEST_LTS"
        echo "  ✓ Set Node.js $LATEST_LTS as global"

        # 5. pnpm 설치
        echo ""
        echo "Installing pnpm..."
        if nodenv exec npm install -g pnpm; then
            echo "  ✓ pnpm installed successfully"
        else
            echo "  ✗ pnpm installation failed. You can install it manually later:"
            echo "    nodenv exec npm install -g pnpm"
        fi
    else
        echo ""
        echo "✗ Node.js $LATEST_LTS installation failed. Skipping pnpm installation."
        echo ""
        echo "You can try installing Node.js manually:"
        echo "  nodenv install $LATEST_LTS"
        echo "  nodenv global $LATEST_LTS"
        exit 1  # 스크립트 완전히 종료
    fi
else
    # 이미 설치됨
    echo ""
    echo "  ✓ Node.js $LATEST_LTS already installed"
    nodenv global "$LATEST_LTS"
    echo "  ✓ Set Node.js $LATEST_LTS as global"

    # pnpm 설치 여부 확인
    if ! command -v pnpm &> /dev/null; then
        echo ""
        echo "Installing pnpm..."
        if nodenv exec npm install -g pnpm; then
            echo "  ✓ pnpm installed successfully"
        else
            echo "  ✗ pnpm installation failed. You can install it manually later:"
            echo "    nodenv exec npm install -g pnpm"
        fi
    else
        echo ""
        echo "  ✓ pnpm already installed"
    fi
fi

# 6. 실제 설치된 버전 확인
echo ""
echo "========================================"
echo "Installed Versions:"
echo "========================================"
echo "Node.js:   $(nodenv exec node --version)"
echo "npm:       $(nodenv exec npm --version)"
echo "pnpm:      $(nodenv exec pnpm --version 2>/dev/null || echo 'Not installed')"
echo "========================================"

echo ""
echo "✓ Nodenv setup complete!"
echo ""
echo "터미널을 다시 시작하거나 다음 명령어로 설정을 적용하세요:"
echo "  source ~/.zshrc"

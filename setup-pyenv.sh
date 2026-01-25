#!/usr/bin/env bash

set -euo pipefail

echo "=== Pyenv Setup Script ==="
echo ""

if ! command -v pyenv &> /dev/null; then
    echo "pyenv not found. Please run install.sh first to install pyenv via Homebrew."
    exit 1
fi

echo "Setting up pyenv configuration..."

# pyenv를 .zshrc에 자동으로 설정
ZSHRC="$HOME/.zshrc"

# 이미 설정되어 있는지 체크
if ! grep -q "Pyenv: Python version management" "$ZSHRC"; then
    echo "Adding pyenv configuration to .zshrc..."

    # pyenv 설정 추가 (XDG alias 로딩 이전에)
    # .zshrc의 XDG alias 로딩 라인 찾기
    if grep -q "Load aliases from alias directory" "$ZSHRC"; then
        # 간단한 방법: XDG alias 로딩 라인 뒤에 pyenv 설정 추가
        LINE_NUM=$(grep -n "Load aliases from alias directory" "$ZSHRC" | cut -d: -f1)

        if [ -n "$LINE_NUM" ]; then
            # 해당 라인까지 자르기
            head -n "$LINE_NUM" "$ZSHRC" > /tmp/zshrc_new.tmp

            # pyenv 설정 추가
            {
                echo ""
                echo "# Pyenv: Python version management"
                echo "export PYENV_ROOT=\"\$HOME/.pyenv\""
                echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\""
                echo "eval \"\$(pyenv init -)\""
            } >> /tmp/zshrc_new.tmp

            # 나머지 내용 추가
            tail -n +$((LINE_NUM + 1)) "$ZSHRC" >> /tmp/zshrc_new.tmp

            # 원본 파일 교체
            mv /tmp/zshrc_new.tmp "$ZSHRC"
        fi
    else
        # XDG alias 로딩이 없으면 맨 아래 추가
        {
            echo "# Pyenv: Python version management"
            echo "export PYENV_ROOT=\"$HOME/.pyenv\""
            echo "export PATH=\"$PYENV_ROOT/bin:$PATH\""
            echo "eval \"\$(pyenv init -)\""
        } >> "$ZSHRC"
    fi

    echo "  ✓ Pyenv configuration added to .zshrc"
else
    echo "  ✓ Pyenv configuration already exists in .zshrc"
fi

echo ""
echo "✓ Pyenv setup complete!"
echo ""
echo "Python 버전 설치 예시:"
echo "  pyenv install 3.12.1"
echo ""
echo "Python 글로벌 버전 설정:"
echo "  pyenv global 3.12.1"
echo ""
echo "터미널을 다시 시작하거나 다음 명령어로 설정을 적용하세요:"
echo "  source ~/.zshrc"

#!/usr/bin/env bash

gll() {  # git recent logs with param
  if [ -z "$1" ]; then
    glol
  else
    glol -$1
  fi
}

gllr() {  # git recent 10 logs
  glol -10
}

glls() {  # git log recent commits with stat
  if [ -z "$1" ]; then
    glols
  else
    glols -$1
  fi
}

del_all_branches() {
    # Delete all local branches

    # 현재 active branch를 얻는다.
    current_branch=$(git branch --show-current)

    # 현재 branch를 제외한 branch만 삭제한다.
    git branch | grep -v "$current_branch" | xargs git branch -d
}

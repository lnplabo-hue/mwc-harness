#!/usr/bin/env bash
# main / work / check 세션 하네스를 현재 폴더에 깐다.
# - 이미 있는 파일은 건드리지 않는다
# - 작업 폴더에 AGENTS.md 가 이미 있으면 그 끝에 규칙을 더한다 (표시 줄이 있으면 다시 더하지 않는다)
# - README.md 는 만들지 않는다 (작업 폴더의 README 는 과제 설명일 수 있다)
set -euo pipefail
src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mark="# === harness rules ==="

put() {
  if [ -e "$1" ]; then echo "두는 것: $1"; else cp "$src/$1" "$1"; echo "만듦: $1"; fi
}

if [ ! -e AGENTS.md ]; then
  { printf '%s\n' "$mark"; cat "$src/AGENTS.md"; } > AGENTS.md
  echo "만듦: AGENTS.md"
elif ! grep -qF "$mark" AGENTS.md; then
  { printf '\n%s\n' "$mark"; cat "$src/AGENTS.md"; } >> AGENTS.md
  echo "더함: AGENTS.md 끝에 규칙"
else
  echo "두는 것: AGENTS.md (규칙 이미 있음)"
fi

for f in SPEC.md STATE.md LOG.md TALK.md REPORT.md USAGE.md .gitignore; do put "$f"; done
mkdir -p handoff work check
[ -d .git ] || { git init -q && echo "만듦: git 저장소"; }
echo "끝. USAGE.md 를 열고 틀 단계부터. 터미널 1: codex → main, 터미널 2: codex → work"

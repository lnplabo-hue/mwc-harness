# 쓰는 법 (사람이 읽는다. Codex 는 읽지 않는다)

세션 셋(main, work, check)이 한 작업 폴더를 파일로만 주고받는 틀. 규칙은 `AGENTS.md` 열한 줄과 단계 줄. 요청과 결과의 칸은 규칙 4·5, 문서의 칸은 각 파일 머리.

## 깔기
- 기본: 작업 폴더에서 `git clone https://github.com/lnplabo-hue/mwc-harness.git _h && bash _h/setup.sh && rm -rf _h`
  - git 이 없으면: `curl -sL https://github.com/lnplabo-hue/mwc-harness/archive/refs/heads/main.tar.gz | tar xz && bash mwc-harness-main/setup.sh && rm -rf mwc-harness-main`
  - 또는 Codex 에게 한글로: 「https://github.com/lnplabo-hue/mwc-harness 를 받아서 setup.sh 를 실행해」
- 저장소가 안 되면: 터미널 1 에서 `codex` → 「너는 main 이다. 아래를 AGENTS.md 에 그대로 쓰고, SPEC STATE LOG TALK REPORT 를 빈 틀로, handoff work check 폴더를 만들어 목록을 보여줘.」 뒤에 규칙 전문. 문서 머리의 양식은 그다음에 따로 붙여 넣는다
- 있는 파일은 덮어쓰지 않는다. 작업 폴더의 AGENTS.md 가 있으면 끝에 더한다. README.md 는 만들지 않는다. 과제가 README 나 다른 이름을 요구하면 정리 단계에 main 이 그 이름으로 쓴다

## 틀 단계 (10분 안)
- 환경 점검을 터미널에 치고 출력을 main 에 「SPEC 제약에 적어」 와 함께 붙인다 (python3 이 없으면 python)
  ```bash
  nproc; free -h; df -h .; nvidia-smi 2>/dev/null || echo "GPU 없음"
  python3 - <<'EOF'
  import importlib, importlib.util
  for m in ["numpy", "pandas", "sklearn", "torch", "fastapi", "streamlit"]:
      print(m, getattr(importlib.import_module(m), "__version__", "?") if importlib.util.find_spec(m) else "없음")
  EOF
  python3 -c "import urllib.request as u; u.urlopen('https://pypi.org', timeout=5); print('망 됨')" 2>/dev/null || echo "망 안 됨"
  ```
- `.gitignore` 에 데이터 폴더를 더한다 (예: `data/`). 주어진 데이터는 `chmod -R a-w mwc-harness-main` 로 잠근다 (선택)
- 터미널 1: `codex` → `main`. 터미널 2: `codex` → `work`
- 첫 세션에 상황 질문 (암송 대신. 틀리면 그 규칙 번호를 가리키며 다시 읽게 한다)
  - work: ① 002 하다가 SPEC 을 바꿔야 하면 쓰는 파일은? (002_ask, 결과는 안 씀) ② 결과를 쓴 뒤 002_wip 는? (지움) ③ 출처가 기억뿐인 사실은? (기억, 확인 못 함)
  - main: ① 결과를 읽은 직후 하는 셋? (date, LOG, commit) ② 내가 "응" 만 하면 LOG 에? (결정과 까닭) ③ 코드를 고쳐 달라면? (요청으로)
  - check: ① 안 읽는 것? (work 의 결과 보고) ② 숫자 없는 기준? (사람이 볼 것) ③ 버그를 보면? (고치지 않고 적음)

## 하루
- 담당자 말: main 에 `talk` 뒤에 원문 붙여 넣기 → TALK 에 쌓이고 SPEC 반영과 다음 질문을 제안. 담당자가 README 만 되풀이하면 두 번까지 묻고 그 뒤는 SPEC 가정에 "확인 못 함"
- 요청: main 에 「work 에 요청 써줘: …」 → main 이 번호를 알림 → work 창에서 `work` 를 치면 "NNN 할까요?" → 「응」 (또는 번호)
- 결과: main 에 「NNN 결과 읽어줘」 → 논의 → 결정 (main 이 date, LOG, commit 을 하고 보여 준다). commit 때 승인을 물으면 승인한다. Codex 기본 설정은 .git 쓰기를 막아서, 승인 없이 "commit 실패" 라고 하면 내가 터미널에 `git add -A && git commit -m "NNN 받음"` 을 친다
- work 비우기: 기본은 요청 하나 끝나면 `/clear` → `work`. 같은 파일을 이어 고치는 작은 요청이면 세션을 유지한다. worktree 를 물으면 "현재 worktree 사용"
- work 가 멈추면: `status` 에 `_ask` 가 보임 → 읽고 main 에 「NNN 답: …」 → work 에 NNN 다시
- work 가 굳으면 (5분 넘게 출력 없음): Esc → `save` → `/clear` → `work` → 같은 번호
- 둘을 같이: 유형이 다르면 work 와 check 창. 둘 다 work 몫이면 창을 하나 더 열어 `work` → 다른 번호. main 에 「NNN 과 MMM 같이 돌리고 싶어」 라고 하면 고칠 곳을 나눠 준다
- 현황: main 에 `status` (단계, handoff 상태 표, LOG 끝 5줄)
- 검증: main 에 「검증 요청 써줘」 (결과물 경로, 실행 명령, 재는 방법을 옮겨 적음) → 터미널 3: `codex` → `check` → "NNN 할까요?" → 「응」. 끝나도 창을 닫지 않고 `/clear` (터미널 기록을 남긴다)
- 압축: `/status` 에서 맥락이 절반을 넘으면 다음 매듭(결과 읽고 결정한 직후)에 main 에 `save` → `/compact` → `main` → 「지금 상태 세 줄로」. STATE 와 맞는지 본다
- 끝: 정리 단계에서 main 에 「제출물 이름을 과제 안내와 대조하고 REPORT 써줘」 → 새 터미널에서 실행법을 그대로 한 번 → commit → 제출. 끝난 뒤 설명할 일이 있으면 LOG 와 REPORT 를 먼저 읽는다

## 단계 (AGENTS.md 끝줄)
틀 → 정의 → 설계 → 최소판 → 검증 → 개선 → 정리 → 제출. 최소판이 서기 전에 검증으로 가지 않고, 안 되면 내가 더한 기능을 빼서 되게 한다

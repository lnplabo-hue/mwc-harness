# main / work / check 하네스

Codex CLI 터미널 셋이 한 작업 폴더를 파일로만 주고받는 작업 틀입니다. 규칙 파일 하나(`AGENTS.md`), 공유 문서 다섯(`SPEC` `STATE` `LOG` `TALK` `REPORT`), 요청과 결과 폴더(`handoff/`)로 이루어집니다. 과제 내용은 들어 있지 않습니다.

- `main`: 사람과 논의하고 기록하고 요청을 씁니다
- `work`: 요청받은 조사·설계·구현만 합니다
- `check`: 검증만 하고 고치지 않습니다

## 깔기

작업 폴더에서

```bash
git clone https://github.com/lnplabo-hue/mwc-harness.git _h && bash _h/setup.sh && rm -rf _h
```

있는 파일은 덮어쓰지 않고, `AGENTS.md` 가 이미 있으면 끝에 규칙을 더합니다. 이 README 는 작업 폴더에 복사되지 않습니다.

## 그다음

작업 폴더에 복사된 `USAGE.md` 를 열고 위에서부터 따라 합니다.

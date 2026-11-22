# Claude Video Skills

A set of [Claude Code](https://claude.com/claude-code) skills that make animated YouTube videos for faceless channels. Every frame is drawn in code. No AI video generator and no stock footage.

| Skill | Format | Look | Stack | Author |
|---|---|---|---|---|
| [`2d-long-form`](skills/2d-long-form) | 16:9, 3 to 15 min | Flat ink-on-paper 2D cartoon. Script in English, Vietnamese, French or German | Python, skia-python, ffmpeg, sherpa-onnx | Duongvu05 |
| [`claude-3d-animated-shorts`](skills/claude-3d-animated-shorts) | 9:16 Shorts | Real 3D cartoon characters in lit 3D sets | three.js, Node, Chrome, ElevenLabs | [thuann-vn](https://github.com/thuann-vn/claude-3d-animated-shorts) (MIT) |
| [`stick-figure-shorts`](skills/stick-figure-shorts) | 16:9 or 9:16, 20 to 60 s | White round-head stick figures on moody sets | Remotion, React, ElevenLabs | [deenukhan](https://github.com/deenukhan/stick-figure-shorts) |

## Install

```bash
git clone --recursive https://github.com/Duongvu05/claude-video-skills.git
cd claude-video-skills
bash install.sh          # links all three skills into ~/.claude/skills
bash install.sh --deps   # optional. Also installs each skill's tools and models
```

Restart Claude Code after installing. Then just ask for a video, for example "Make a 5 minute 2D animated video about compound interest".

Options for `install.sh`
- `--copy` copies the skills instead of linking them. Links are the default so `git pull` updates them.
- `--force` replaces skills that are already installed.
- `--deps` runs each skill's own setup.

If you cloned without `--recursive`, `install.sh` fetches the missing submodule for you.

### Requirements

- All skills need `ffmpeg`.
- `2d-long-form` needs Python 3. Its `scripts/setup.sh` installs the Python packages and the speech model for your market language (`en`, `vi`, `fr` or `de`).
- `claude-3d-animated-shorts` needs Node 18+, Python 3 with Pillow and Chrome or Chromium. Run `scripts/fetch-assets.sh` once for the rig and fonts.
- `stick-figure-shorts` needs Node 18+ and Python 3. Voice comes from ElevenLabs (connector or `ELEVENLABS_API_KEY`).

See each skill's own `README.md`, `SETUP.md` or `SKILL.md` for details.

## Updating

```bash
git pull
git submodule update --remote   # pulls the latest stick-figure-shorts
```

## Credits and licences

The three skills keep their own authors and licences. See [THIRD_PARTY.md](THIRD_PARTY.md).

- `claude-3d-animated-shorts` is included as a copy under its MIT licence (`skills/claude-3d-animated-shorts/LICENSE`).
- `stick-figure-shorts` has no licence file upstream. It is linked as a git submodule, so its code stays in the author's repo and is not redistributed here.
- `2d-long-form` credits its own sources in `skills/2d-long-form/CREDITS.md`.

Check the terms of paid tools like ElevenLabs and Remotion before you monetise a channel.

---

## Tiếng Việt

Bộ skill cho Claude Code để làm video hoạt hình YouTube cho kênh không lộ mặt. Mọi khung hình đều vẽ bằng code.

- `2d-long-form` làm video 2D dài 3 đến 15 phút. Có 4 thị trường là Anh, Việt, Pháp và Đức. Skill luôn trò chuyện bằng tiếng Việt.
- `claude-3d-animated-shorts` làm Shorts dọc với nhân vật 3D.
- `stick-figure-shorts` làm phim người que ngắn 20 đến 60 giây.

Cài đặt

```bash
git clone --recursive https://github.com/Duongvu05/claude-video-skills.git
cd claude-video-skills && bash install.sh --deps
```

Sau đó khởi động lại Claude Code và yêu cầu làm video.

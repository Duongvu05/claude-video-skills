# Claude Video Skills

One [Claude Code](https://claude.com/claude-code) skill, `animated-video`, that makes animated YouTube videos for faceless channels. Every frame is drawn in code. No AI video generator and no stock footage.

When you ask for a video, Claude first asks **2D or 3D**. For 2D it then asks which 2D style. After that it follows the workflow of the chosen style.

```
                 ┌─ 2D ─┬─ Long form (3-15 min)      → styles/2d-long-form
"Make a video" ──┤      └─ Stick-figure short (20-60 s) → styles/stick-figure-shorts
                 └─ 3D ──── Vertical Short (35-45 s)   → styles/3d-shorts
```

| Style | Format | Look | Stack | Author |
|---|---|---|---|---|
| [2D long form](styles/2d-long-form) | 16:9, 3 to 15 min | Flat ink-on-paper cartoon. Script in English, Vietnamese, French or German | Python, skia-python, ffmpeg, sherpa-onnx | Duongvu05 |
| [2D stick figure](styles/stick-figure-shorts) | 16:9 or 9:16, 20 to 60 s | White round-head stick figures on moody sets | Remotion, React, ElevenLabs | [deenukhan](https://github.com/deenukhan/stick-figure-shorts) |
| [3D shorts](styles/3d-shorts) | 9:16, 35 to 45 s | Real 3D cartoon characters in lit 3D sets | three.js, Node, Chrome, ElevenLabs | [thuann-vn](https://github.com/thuann-vn/claude-3d-animated-shorts) (MIT) |

## Install

The quickest way is to clone straight into your skills folder.

```bash
git clone --recursive https://github.com/Duongvu05/claude-video-skills.git ~/.claude/skills/animated-video
```

Or clone anywhere and run the installer.

```bash
git clone --recursive https://github.com/Duongvu05/claude-video-skills.git
cd claude-video-skills
bash install.sh          # links the repo to ~/.claude/skills/animated-video
bash install.sh --deps   # optional. Also installs the tools of all three styles
```

Restart Claude Code. Then ask for a video, for example "Make an animated video about compound interest".

Options for `install.sh`
- `--copy` copies instead of linking. Linking is the default so `git pull` updates the skill.
- `--force` replaces an existing install.
- `--deps` runs the setup of every style.

If you cloned without `--recursive`, run `git submodule update --init` (or `install.sh`, which does it for you).

### Requirements

- Every style needs `ffmpeg`.
- 2D long form needs Python 3. `styles/2d-long-form/scripts/setup.sh <en|vi|fr|de>` installs the Python packages and the speech model.
- 2D stick figure needs Node 18+ and Python 3. Voice comes from ElevenLabs (connector or `ELEVENLABS_API_KEY`). See `styles/stick-figure-shorts/SETUP.md`.
- 3D shorts needs Node 18+, Python 3 with Pillow and Chrome or Chromium. Run `styles/3d-shorts/scripts/fetch-assets.sh` once.

Claude also checks these before the first render and offers to run the setup.

## Updating

```bash
git pull
git submodule update --remote   # pulls the latest stick-figure-shorts
```

## Credits and licences

Each style keeps its own author and licence. See [THIRD_PARTY.md](THIRD_PARTY.md).

- `styles/3d-shorts` is a copy of claude-3d-animated-shorts under its MIT licence (`styles/3d-shorts/LICENSE`).
- `styles/stick-figure-shorts` has no licence file upstream. It is linked as a git submodule, so its code stays in the author's repo and is not redistributed here.
- `styles/2d-long-form` credits its own sources in `styles/2d-long-form/CREDITS.md`.

Check the terms of paid tools like ElevenLabs and Remotion before you monetise a channel.

---

## Tiếng Việt

Một skill duy nhất cho Claude Code tên `animated-video`. Skill này làm video hoạt hình YouTube cho kênh không lộ mặt. Mọi khung hình đều vẽ bằng code.

Khi bạn yêu cầu làm video, Claude sẽ hỏi **"Bạn muốn làm phim 2D hay 3D?"**

- Chọn **2D** thì Claude hỏi tiếp kiểu 2D. Có video dài 3 đến 15 phút phong cách nét mực, hoặc phim người que ngắn 20 đến 60 giây.
- Chọn **3D** thì Claude làm Shorts dọc với nhân vật 3D thật.

Cài đặt

```bash
git clone --recursive https://github.com/Duongvu05/claude-video-skills.git ~/.claude/skills/animated-video
```

Sau đó khởi động lại Claude Code và yêu cầu làm video.

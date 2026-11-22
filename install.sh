#!/usr/bin/env bash
# Install this repo as one Claude Code skill named "animated-video".
#
# Usage:
#   bash install.sh            # symlink the repo to ~/.claude/skills/animated-video (git pull updates it)
#   bash install.sh --copy     # copy instead of symlink
#   bash install.sh --force    # replace an existing install
#   bash install.sh --deps     # also install the tools of all three styles (ffmpeg must already be installed)
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
NAME=animated-video
MODE=link FORCE=0 DEPS=0
for a in "$@"; do
  case "$a" in
    --copy) MODE=copy ;;
    --force) FORCE=1 ;;
    --deps) DEPS=1 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "unknown option $a"; exit 1 ;;
  esac
done

# stick-figure-shorts is a git submodule. Fetch it if the repo was cloned without --recursive.
if [ -e "$REPO/.git" ] && [ ! -f "$REPO/styles/stick-figure-shorts/SKILL.md" ]; then
  echo "fetching submodules..."
  git -C "$REPO" submodule update --init --recursive
fi

target="$DEST/$NAME"
mkdir -p "$DEST"
if [ "$(cd "$target" 2>/dev/null && pwd -P)" = "$(cd "$REPO" && pwd -P)" ]; then
  echo "$NAME is already installed at $target"
elif [ -e "$target" ] || [ -L "$target" ]; then
  if [ "$FORCE" = 1 ]; then
    rm -rf "$target"
  else
    echo "$target already exists. Use --force to replace it."; exit 1
  fi
fi
if [ ! -e "$target" ]; then
  if [ "$MODE" = copy ]; then cp -r "$REPO" "$target"; else ln -s "$REPO" "$target"; fi
  echo "installed $NAME -> $target ($MODE)"
fi

if [ "$DEPS" = 1 ]; then
  echo "--- 2D long form (English model by default. Run styles/2d-long-form/scripts/setup.sh vi|fr|de for others)"
  bash "$REPO/styles/2d-long-form/scripts/setup.sh" en || echo "2d-long-form setup failed, see output above"
  echo "--- 3D shorts"
  ( cd "$REPO/styles/3d-shorts" && bash scripts/fetch-assets.sh && cd engine && npm install ) \
    || echo "3d-shorts setup failed, see output above"
  echo "--- 2D stick-figure shorts"
  pip install -q faster-whisper 2>/dev/null || pip install -q --break-system-packages faster-whisper \
    || echo "faster-whisper install failed (optional if you use the ElevenLabs API for timings)"
fi

echo
echo "Done. Restart Claude Code, then ask for a video. It will ask 2D or 3D first."

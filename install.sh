#!/usr/bin/env bash
# Install the video skills in this repo into ~/.claude/skills.
#
# Usage:
#   bash install.sh            # symlink every skill (git pull updates them)
#   bash install.sh --copy     # copy instead of symlink
#   bash install.sh --force    # replace skills that are already installed
#   bash install.sh --deps     # also run each skill's own setup (ffmpeg, Node, Python packages, models)
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
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
if [ -d "$REPO/.git" ] && [ ! -f "$REPO/skills/stick-figure-shorts/SKILL.md" ]; then
  echo "fetching submodules..."
  git -C "$REPO" submodule update --init --recursive
fi

mkdir -p "$DEST"
for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || { echo "skip $name (no SKILL.md)"; continue; }
  target="$DEST/$name"
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$FORCE" = 1 ]; then rm -rf "$target"; else echo "skip $name (already at $target, use --force to replace)"; continue; fi
  fi
  if [ "$MODE" = copy ]; then cp -r "${dir%/}" "$target"; else ln -s "${dir%/}" "$target"; fi
  echo "installed $name -> $target ($MODE)"
done

if [ "$DEPS" = 1 ]; then
  echo "--- 2d-long-form setup (English model by default, run its setup.sh with vi/fr/de for others)"
  bash "$REPO/skills/2d-long-form/scripts/setup.sh" en || echo "2d-long-form setup failed, see output above"
  echo "--- claude-3d-animated-shorts setup"
  ( cd "$REPO/skills/claude-3d-animated-shorts" && bash scripts/fetch-assets.sh && cd engine && npm install ) \
    || echo "claude-3d-animated-shorts setup failed, see output above"
  echo "--- stick-figure-shorts setup"
  pip install -q faster-whisper 2>/dev/null || pip install -q --break-system-packages faster-whisper \
    || echo "faster-whisper install failed (optional if you use the ElevenLabs API for timings)"
fi

echo
echo "Done. Restart Claude Code so it picks up the new skills."

#!/usr/bin/env bash
# One-time setup for the 2D Long Form engine (Linux/macOS sandbox or local machine).
# Installs Python packages and the offline speech model for the market language (times the picture to the voiceover).
# Usage: bash setup.sh [en|vi|fr|de]   (default en; run again with another language to add its model)
set -e
PY=${PYTHON:-python3}
command -v ffmpeg >/dev/null || { echo "ffmpeg missing: install it (apt-get install -y ffmpeg / brew install ffmpeg)"; exit 1; }
$PY -m pip install -q skia-python numpy scipy soundfile sherpa-onnx 2>/dev/null \
  || $PY -m pip install -q --break-system-packages skia-python numpy scipy soundfile sherpa-onnx
$PY -c "import skia, numpy, scipy, soundfile, sherpa_onnx; print('python packages ok')"
M=${RM_MODELS:-$HOME/models}; mkdir -p "$M"; cd "$M"
LANG_=${1:-en}
case "$LANG_" in
  en) NAME=sherpa-onnx-nemo-parakeet-tdt-0.6b-v2-int8 ;;
  fr|de) NAME=sherpa-onnx-nemo-parakeet-tdt-0.6b-v3-int8 ;;
  vi) NAME=sherpa-onnx-zipformer-vi-int8-2025-04-20 ;;
  *) echo "unknown language $LANG_ (use en, vi, fr or de)"; exit 1 ;;
esac
if ! ls "$NAME"/encoder*.onnx >/dev/null 2>&1; then
  echo "downloading $LANG_ speech model ($NAME, GitHub release)..."
  curl -sSL -O "https://github.com/k2-fsa/sherpa-onnx/releases/download/asr-models/$NAME.tar.bz2" && tar xjf "$NAME.tar.bz2" && rm -f "$NAME.tar.bz2" \
    || echo "WARNING: model download failed. Alignment will fall back to pause detection (less exact)."
fi
ls "$NAME"/encoder*.onnx >/dev/null 2>&1 && echo "speech model ok ($LANG_): $M/$NAME"
echo "cpus: $(nproc 2>/dev/null || sysctl -n hw.ncpu)"

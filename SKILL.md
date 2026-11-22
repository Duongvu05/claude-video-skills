---
name: animated-video
description: "Make animated YouTube videos for faceless channels, drawn entirely in code, in 2D or 3D. It always starts by asking whether the user wants a 2D or a 3D film, then picks one of three styles - a 2D long-form ink-on-paper video (3 to 15 min, 16:9, English/Vietnamese/French/German), a 2D stick-figure story short (20 to 60 s), or a 3D animated vertical Short with real 3D characters (three.js). Use it for any request to make an animated video, cartoon, explainer, story video, YouTube Short, faceless channel video, stick-figure or stickman video, 2D or 3D animation, or when the user gives only a topic, a script or a voiceover and wants a video from it."
---

# Animated Video

One skill, three styles. This file only routes. The real workflow for each style lives in its own folder under `styles/`.

| Choice | Style folder | What it makes |
|---|---|---|
| 2D, long form | `styles/2d-long-form/` | 16:9 video of 3, 5, 10 or 15 min. Flat ink-on-paper cartoon. Script in English, Vietnamese, French or German. Python + skia + ffmpeg. |
| 2D, stick figure | `styles/stick-figure-shorts/` | 20 to 60 s story film, 16:9 (9:16 on request). White round-head stick figures on moody sets. Remotion + ElevenLabs. |
| 3D | `styles/3d-shorts/` | 9:16 vertical Short of about 35 to 45 s. Real rigged 3D characters in lit 3D sets. three.js + Chrome + ElevenLabs. |

## Step 1. Ask 2D or 3D (always first)

Before anything else, even when the user already gave a topic, a script or a voiceover, ask with **AskUserQuestion** (plain text if that tool is missing). Write the question in the language the user writes in. In Vietnamese it is

**"Bạn muốn làm phim 2D hay 3D?"**

with exactly two options

- **2D** - hoạt hình phẳng vẽ bằng code. Có video dài 3 đến 15 phút hoặc phim người que ngắn.
- **3D** - Shorts dọc 9:16 với nhân vật 3D thật, dài khoảng 35 đến 45 giây.

Only skip this question if the user's message already says "2D" or "3D" in plain words. Never guess the dimension from the topic.

## Step 2. If 2D, ask which 2D style

Ask a second AskUserQuestion, again in the user's language. In Vietnamese

**"Bạn muốn kiểu 2D nào?"**

- **Video dài (3 đến 15 phút)** - phong cách nét mực trên giấy, 16:9, cho kênh YouTube dài. Thị trường Anh, Việt, Pháp hoặc Đức. → `styles/2d-long-form/`
- **Phim người que ngắn (20 đến 60 giây)** - nhân vật đầu tròn trắng, chân tay que, 16:9 hoặc 9:16. → `styles/stick-figure-shorts/`

Skip it only if the user already named the style in plain words (for example "stick figure", "người que", or a length of several minutes).

If the user chose 3D, there is only one 3D style. Go straight to `styles/3d-shorts/`.

## Step 3. Hand over to the chosen style

1. Let `<root>` be the folder this file is in. Let `<style>` be `<root>/styles/<chosen folder>`.
2. Read `<style>/SKILL.md` in full and follow it from its first step. From here on its rules apply, including its own first questions (for example 2d-long-form asks for the market language next and always talks to the user in Vietnamese).
3. Whenever that file says "the skill folder", it means `<style>`. Run its commands from `<style>`. Its relative paths (`engine/`, `scripts/`, `references/`, `assets/`, `tools/`) are relative to `<style>`.
4. Do not mix styles in one film. Do not load the other styles' files.

## Setup check

Before the first render in a style, check that its tools are installed and run its setup if not.

- `2d-long-form` needs ffmpeg and Python 3. Run `bash scripts/setup.sh <en|vi|fr|de>` from `<style>`.
- `stick-figure-shorts` needs Node 18+, ffmpeg and Python 3. See `<style>/SETUP.md`. Voice comes from the ElevenLabs connector or `ELEVENLABS_API_KEY`.
- `3d-shorts` needs Node 18+, Python 3 with Pillow, ffmpeg and Chrome or Chromium. From `<style>` run `bash scripts/fetch-assets.sh`, then `npm install` inside `engine/`.

If `styles/stick-figure-shorts/` is empty, the repo was cloned without submodules. Run `git -C <root> submodule update --init` and continue.

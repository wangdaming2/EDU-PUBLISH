#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DEST_DIR="$ROOT_DIR/skills"
REPO_URL="https://github.com/guiguisocute/JXNU-PUBLISH-skills.git"
REPO_REF="${JXNU_PUBLISH_SKILLS_REF:-main}"
TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/jxnu-publish-skills.XXXXXX")"

SKILLS=(
  daily-reconcile
  incremental-process
  map-source
  merge-supplement
  parse-and-create-cards
  validate-and-push
  write-conclusion
  write-worklog
)

cleanup() {
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT

if ! command -v git >/dev/null 2>&1; then
  echo "git is required to install project skills." >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

git clone \
  --depth 1 \
  --filter=blob:none \
  --sparse \
  --branch "$REPO_REF" \
  "$REPO_URL" \
  "$TMP_DIR/repo" \
  >/dev/null

git -C "$TMP_DIR/repo" sparse-checkout set skills >/dev/null

installed=0
skipped=0

for skill in "${SKILLS[@]}"; do
  src="$TMP_DIR/repo/skills/$skill"
  dest="$DEST_DIR/$skill"

  if [ ! -f "$src/SKILL.md" ]; then
    echo "missing SKILL.md for $skill in $REPO_URL@$REPO_REF" >&2
    exit 1
  fi

  if [ -e "$dest" ]; then
    echo "skip: skills/$skill already exists"
    skipped=$((skipped + 1))
    continue
  fi

  cp -R "$src" "$dest"
  echo "installed: skills/$skill"
  installed=$((installed + 1))
done

echo "done: installed $installed skill(s), skipped $skipped existing skill(s)"

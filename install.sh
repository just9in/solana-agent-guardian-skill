#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Solana Agent Guardian Skill installer

Usage:
  bash install.sh --user
  bash install.sh --project /path/to/project
  bash install.sh --agents --project /path/to/project
  bash install.sh --prefix /custom/path

Options:
  --user          Install to ~/.claude/skills/solana-agent-guardian
  --project PATH  Install to PATH/.claude/skills/solana-agent-guardian
  --agents        Use .agents/skills instead of .claude/skills with --project
  --prefix PATH   Install directly to PATH/solana-agent-guardian
  -h, --help      Show this help

This installer only copies local files. It does not use curl, sudo, package
managers, network calls, or remote shell scripts.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE=""
PROJECT_PATH=""
PREFIX=""
USE_AGENTS="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user) MODE="user"; shift ;;
    --project) MODE="project"; PROJECT_PATH="${2:-}"; [[ -n "$PROJECT_PATH" ]] || { echo "error: --project requires a path" >&2; exit 1; }; shift 2 ;;
    --agents) USE_AGENTS="true"; shift ;;
    --prefix) MODE="prefix"; PREFIX="${2:-}"; [[ -n "$PREFIX" ]] || { echo "error: --prefix requires a path" >&2; exit 1; }; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unknown option $1" >&2; usage; exit 1 ;;
  esac
done

[[ -n "$MODE" ]] || { echo "error: choose --user, --project, or --prefix" >&2; usage; exit 1; }

if [[ "$MODE" == "user" ]]; then
  DEST="$HOME/.claude/skills/solana-agent-guardian"
elif [[ "$MODE" == "project" ]]; then
  BASE=".claude"; [[ "$USE_AGENTS" == "true" ]] && BASE=".agents"
  DEST="$PROJECT_PATH/$BASE/skills/solana-agent-guardian"
else
  DEST="$PREFIX/solana-agent-guardian"
fi

mkdir -p "$DEST"
for dir in skill commands agents rules schemas examples; do
  [[ -d "$SCRIPT_DIR/$dir" ]] || continue
  rm -rf "$DEST/$dir"
  mkdir -p "$DEST/$dir"
  cp -R "$SCRIPT_DIR/$dir/." "$DEST/$dir/"
done
for file in README.md LICENSE SECURITY.md CHANGELOG.md; do
  [[ -f "$SCRIPT_DIR/$file" ]] && cp "$SCRIPT_DIR/$file" "$DEST/$file"
done
cat > "$DEST/INSTALLATION.txt" <<INFO
Installed Solana Agent Guardian Skill at:
$DEST

Entry point:
$DEST/skill/SKILL.md
INFO

echo "Installed Solana Agent Guardian Skill to $DEST"

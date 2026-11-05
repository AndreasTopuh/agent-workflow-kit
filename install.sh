#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/AndreasTopuh/agent-workflow-kit.git"
RAW_BASE="https://raw.githubusercontent.com/AndreasTopuh/agent-workflow-kit/main"

# Text styling
BOLD="\033[1m"
GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RESET="\033[0m"

echo -e "${BOLD}🤖 Agent Workflow Kit Installer${RESET}"
echo -e "Make any AI coding agent work like a careful senior engineer.\n"

CHOICE=""

# Parse flags
for arg in "$@"; do
  case "$arg" in
    --project|-p)
      CHOICE="1"
      ;;
    --core|-c)
      CHOICE="2"
      ;;
    --global|-g)
      CHOICE="3"
      ;;
    --help|-h)
      echo "Usage: curl -fsSL .../install.sh | bash -s -- [OPTION]"
      echo ""
      echo "Options:"
      echo "  --project, -p   Install full kit (rules + skills + reviewer) in current folder [Default]"
      echo "  --core, -c      Install core rules only (AGENTS.md & GEMINI.md) in current folder"
      echo "  --global, -g    Install globally across all projects (~/.gemini, ~/.codex, ~/.claude)"
      exit 0
      ;;
  esac
done

# If no flag was passed and interactive terminal is available, prompt user
if [ -z "$CHOICE" ]; then
  if [ -t 0 ] || [ -e /dev/tty ]; then
    echo "Choose installation mode:"
    echo -e "  ${BOLD}[1]${RESET} Current Project: ${BOLD}Full Kit${RESET} (Rules + Skills + Reviewer) ${GREEN}(Recommended)${RESET}"
    echo -e "  ${BOLD}[2]${RESET} Current Project: ${BOLD}Core Rules Only${RESET} (\"The Brain\" - AGENTS.md & GEMINI.md)"
    echo -e "  ${BOLD}[3]${RESET} Global Setup:   ${BOLD}All Projects on Machine${RESET} (~/.gemini, ~/.codex, ~/.claude)"
    echo ""
    printf "Enter selection [1-3] (Default: 1): "
    if [ -t 0 ]; then
      read -r input_choice
    else
      read -r input_choice < /dev/tty
    fi
    CHOICE="${input_choice:-1}"
  else
    CHOICE="1"
  fi
fi

# Create a temporary directory for cloning
TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'awk-install')
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

echo -e "\n${BLUE}==>${RESET} Fetching kit from GitHub..."
git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR" 2>/dev/null || {
  echo -e "${YELLOW}Warning:${RESET} git clone failed, falling back to direct file download..."
  mkdir -p "$TEMP_DIR/.agent/rules" "$TEMP_DIR/.agent/agents" "$TEMP_DIR/.agent/skills/root-cause" "$TEMP_DIR/.agent/skills/prove-in-browser" "$TEMP_DIR/.agent/skills/ship"
  curl -fsSL "$RAW_BASE/AGENTS.md" -o "$TEMP_DIR/AGENTS.md"
  curl -fsSL "$RAW_BASE/GEMINI.md" -o "$TEMP_DIR/GEMINI.md"
  curl -fsSL "$RAW_BASE/.agent/rules/checklist.md" -o "$TEMP_DIR/.agent/rules/checklist.md"
  curl -fsSL "$RAW_BASE/.agent/agents/reviewer.md" -o "$TEMP_DIR/.agent/agents/reviewer.md"
  curl -fsSL "$RAW_BASE/.agent/skills/root-cause/SKILL.md" -o "$TEMP_DIR/.agent/skills/root-cause/SKILL.md"
  curl -fsSL "$RAW_BASE/.agent/skills/prove-in-browser/SKILL.md" -o "$TEMP_DIR/.agent/skills/prove-in-browser/SKILL.md"
  curl -fsSL "$RAW_BASE/.agent/skills/ship/SKILL.md" -o "$TEMP_DIR/.agent/skills/ship/SKILL.md"
}

backup_if_exists() {
  local file="$1"
  if [ -f "$file" ]; then
    echo -e "${YELLOW}Notice:${RESET} Existing $file found. Backing up to ${file}.bak"
    cp "$file" "${file}.bak"
  fi
}

case "$CHOICE" in
  1)
    echo -e "${BLUE}==>${RESET} Installing Full Kit into current directory: $(pwd)..."
    backup_if_exists "AGENTS.md"
    backup_if_exists "GEMINI.md"
    cp "$TEMP_DIR/AGENTS.md" .
    cp "$TEMP_DIR/GEMINI.md" .
    cp -r "$TEMP_DIR/.agent" .
    echo -e "\n${GREEN}✔ Successfully installed Full Kit in this project!${RESET}"
    echo -e "Files added:\n  - AGENTS.md\n  - GEMINI.md\n  - .agent/ (checklist, reviewer, skills)"
    echo -e "\nNext step: Open your project in Cursor, Antigravity, or VS Code and chat with AI normally!"
    ;;

  2)
    echo -e "${BLUE}==>${RESET} Installing Core Rules Only (\"The Brain\") into current directory: $(pwd)..."
    backup_if_exists "AGENTS.md"
    backup_if_exists "GEMINI.md"
    cp "$TEMP_DIR/AGENTS.md" .
    cp "$TEMP_DIR/GEMINI.md" .
    echo -e "\n${GREEN}✔ Successfully installed Core Rules in this project!${RESET}"
    echo -e "Files added:\n  - AGENTS.md\n  - GEMINI.md"
    echo -e "\nNext step: Open your project in Cursor, Antigravity, or VS Code and chat with AI normally!"
    ;;

  3)
    echo -e "${BLUE}==>${RESET} Installing globally for all projects on this machine..."
    mkdir -p "$HOME/.gemini" "$HOME/.codex" "$HOME/.claude"
    
    backup_if_exists "$HOME/.gemini/GEMINI.md"
    cp "$TEMP_DIR/GEMINI.md" "$HOME/.gemini/GEMINI.md"
    echo "  - Installed to ~/.gemini/GEMINI.md (Antigravity & Gemini CLI)"

    backup_if_exists "$HOME/.codex/AGENTS.md"
    cp "$TEMP_DIR/AGENTS.md" "$HOME/.codex/AGENTS.md"
    echo "  - Installed to ~/.codex/AGENTS.md (Codex)"

    backup_if_exists "$HOME/.claude/CLAUDE.md"
    cp "$TEMP_DIR/AGENTS.md" "$HOME/.claude/CLAUDE.md"
    echo "  - Installed to ~/.claude/CLAUDE.md (Claude Code)"

    echo -e "\n${GREEN}✔ Global rules installed!${RESET}"
    echo -e "For Cursor: Copy AGENTS.md contents into Cursor -> Settings -> Rules."
    ;;

  *)
    echo -e "${YELLOW}Invalid option. Aborting.${RESET}"
    exit 1
    ;;
esac


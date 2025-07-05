#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# === Colors for logging ===
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# === Logging functions ===
log_info() {
  echo -e "${GREEN}[INFO] $*${NC}"
}

log_error() {
  echo -e "${RED}[ERROR] $*${NC}" >&2
}

# === Cleanup function ===
cleanup() {
  log_info "Cleaning up before exit..."
  # Add your cleanup code here
}
trap cleanup EXIT

# === Usage function ===
usage() {
  cat <<EOF
Usage: $0 [-f filename] [-v]

Options:
  -f FILE     Specify input file
  -v          Enable verbose mode
  -h          Show this help message
EOF
}

# === Argument parsing ===
VERBOSE=0
FILE=""

# while getopts ":f:vh" opt; do
#   case ${opt} in
#     f) FILE="$OPTARG" ;;
#     v) VERBOSE=1 ;;
#     h) usage; exit 0 ;;
#     \?) log_error "Invalid option: -$OPTARG"; usage; exit 1 ;;
#     :) log_error "Option -$OPTARG requires an argument."; usage; exit 1 ;;
#   esac
# done

shift $((OPTIND -1))

install_pkgs() {
    sudo pacman -Syu

    sudo pacman -S --needed \
        base-devel \
        clang \
        cmake \
        git \
        neovim \
        tmux \
        hyprland \
        firefox \
        alacritty \
        waybar \
        ripgrep \
        fd
}

submodules() {
    git submodule update --init ./config/alacritty/alacritty-theme
}

copy_config() {
    cp bashrc ~/.bashrc
    cp vimrc ~/.vimrc
    cp tmux.conf ~/.tmux.conf
    cp -rT config ~/.config
}

hyprland_plugins() {
    hyprpm update
    
    if [[ -z $(hyprpm list | grep split-monitor-workspaces) ]]; then
        yes | hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
        hyprpm enable split-monitor-workspaces
    fi

    hyprpm reload
}

# === Main logic ===
main() {
  log_info "Starting initialization..."

  # if [[ -z "$FILE" ]]; then
  #   log_error "No file provided. Use -f option."
  #   usage
  #   exit 1
  # fi

  # if [[ ! -f "$FILE" ]]; then
  #   log_error "File '$FILE' does not exist."
  #   exit 1
  # fi

  # if [[ "$VERBOSE" -eq 1 ]]; then
  #   log_info "Verbose mode is ON"
  # fi

  # Example processing
  log_info "Cloning Submodules..."
  submodules

  log_info "Installing Packages..."
  install_pkgs

  log_info "Copying Configurations..."
  copy_config

  log_info "Installing Hyprland Plugins..."
  hyprland_plugins

  log_info "Script completed successfully."
}

main "$@"


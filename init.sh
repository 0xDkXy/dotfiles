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
        clangd \
        clang-format \
        cmake \
        mason \
        git \
        neovim \
        tmux \
        hyprland \
        firefox \
        alacritty \
        waybar \

}

submodules() {
    git submodules update --init ./config/alacritty/alacritty-theme
}

copy_config() {
    cp bashrc ~/.bashrc
    cp vimrc ~/.vimrc
    cp tmux.conf ~/.tmux.conf
    cp -rT config ~/.config
}

user_service() {
    _PWD=$(PWD)
    if [[ ! -d $HOME/.config/systemd/user/ ]]; then
        log_info "Dir $HOME/.config/systemd/user doesn't exist. Create a new one"
        mkdir -p $HOME/.config/systemd/user/
    fi

    cp systemd/*.service $HOME/.config/systemd/user/
    sed -i "s/MYHOME/$HOME/g" $HOME/.config/systemd/user/waybar.service

    cd systemd
    shopt -s nullglob
    services=(*.service)
    shopt -u nullglob
    systemctl --user start ${services[@]}

    cd $_PWD
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

  log_info "Installing User Services..."
  user_service

  log_info "Script completed successfully."
}

main "$@"


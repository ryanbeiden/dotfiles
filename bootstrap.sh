#!/usr/bin/env zsh
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# All packages available to stow, OS-aware
ALL_PACKAGES=(zsh git tmux mise starship vivid nvim)
if [[ "$(uname)" == "Darwin" ]]; then
  ALL_PACKAGES+=(ghostty vscode)
fi

echo "==> Installing packages"

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle install --file="$DOTFILES/Brewfile"

elif [[ -f /etc/arch-release ]]; then
  # Arch / Omarchy
  sudo pacman -S --needed - < "$DOTFILES/arch-packages.txt"

  if ! command -v yay >/dev/null; then
    echo "==> Installing yay (AUR helper)"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
  fi

  yay -S --needed - < "$DOTFILES/aur-packages.txt"

else
  echo "Unsupported OS — skipping package install"
fi

echo "==> Installing oh-my-zsh"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Installing bun"
if [[ ! -d "$HOME/.bun" ]]; then
  curl -fsSL https://bun.sh/install | bash
fi

echo "==> Stowing dotfiles"
cd "$DOTFILES"

if [[ $# -gt 0 ]]; then
  # Packages passed as arguments: ./bootstrap.sh zsh git tmux
  STOW_PACKAGES=("$@")
elif command -v fzf >/dev/null; then
  STOW_PACKAGES=("${(@f)$(printf '%s\n' "${ALL_PACKAGES[@]}" | fzf --multi --height=40% --border --prompt='Select packages to stow (tab to select multiple): ')}")
else
  echo "Available packages:"
  for i in {1..${#ALL_PACKAGES[@]}}; do
    printf "%2d) %s\n" "$i" "${ALL_PACKAGES[$i]}"
  done
  echo
  echo "Enter numbers separated by spaces or commas (e.g. 1 3 5), or 'all':"
  read -r choice

  if [[ "$choice" == "all" ]]; then
    STOW_PACKAGES=("${ALL_PACKAGES[@]}")
  else
    choice="${choice//,/ }"   # turn commas into spaces so both formats work
    STOW_PACKAGES=()
    for i in ${(z)choice}; do
      STOW_PACKAGES+=("${ALL_PACKAGES[$i]}")
    done
  fi
fi

if [[ ${#STOW_PACKAGES[@]} -eq 0 ]]; then
  echo "No packages selected, skipping stow."
else
  stow -v "${STOW_PACKAGES[@]}"
fi

echo "==> Done. Restart your shell (or open a new terminal) to pick up all changes."


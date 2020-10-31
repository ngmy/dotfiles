#!/bin/bash
set -Ceuxo pipefail

is_mac() {
  [ "$(uname)" == 'Darwin' ]
}

is_linux() {
  [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]
}

is_ubuntu() {
  is_linux && grep '^NAME="Ubuntu' /etc/os-release >/dev/null 2>&1
}

download() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "ngmy/dotfiles already exists in '${DOTFILES_PATH}'"
    local YN
    read -p 'Do you want to re-download ngmy/dotfiles and continue the installation? (y/N)' YN
    if [ "${YN}" != 'y' ]; then
      echo 'The installation was canceled.'
      exit 1
    fi
    echo "Downloading ngmy/dotfiles to '${DOTFILES_PATH}'..."
    git -C "${DOTFILES_PATH}" pull origin master
    git -C "${DOTFILES_PATH}" submodule update
  else
    echo "Downloading ngmy/dotfiles to '${DOTFILES_PATH}'..."
    git clone https://github.com/ngmy/dotfiles.git "${DOTFILES_PATH}"
    git -C "${DOTFILES_PATH}" submodule init
    git -C "${DOTFILES_PATH}" submodule update
  fi
}

backup() {
  local BACKUP_DATE="$(date +%Y%m%d_%H%M%S)"
  find "${DOTFILES_PATH}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.bashrc_ubuntu' \
    -not -name '.git' \
    -not -name '.gitconfig_linux' \
    -not -name '.gitconfig_mac' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${DOTFILES_PATH}" ls-tree --name-only HEAD {} \
    | xargs -I {} find "${HOME}" -maxdepth 1 -name {} -not -type l \
    | xargs -I {} mv -v {} "{}.${BACKUP_DATE}"
}

install() {
  find "${DOTFILES_PATH}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.bashrc_ubuntu' \
    -not -name '.git' \
    -not -name '.gitconfig_linux' \
    -not -name '.gitconfig_mac' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${DOTFILES_PATH}" ls-tree --name-only HEAD {} \
    | xargs -I {} ln -fnsv "${DOTFILES_PATH}/{}" "${HOME}/{}"
  if is_ubuntu; then
    ln -fnsv "${DOTFILES_PATH}/.bashrc_ubuntu" "${HOME}/.bashrc_os"
  fi
  if is_linux; then
    ln -fnsv "${DOTFILES_PATH}/.gitconfig_linux" "${HOME}/.gitconfig_os"
  fi
  if is_mac; then
    ln -fnsv "${DOTFILES_PATH}/.gitconfig_mac" "${HOME}/.gitconfig_os"
  fi
  source "${HOME}/.bash_profile"
}

install_vim_plugins() {
  vim +PlugInstall +qall
  vim +CocInstall coc-phpls +qall
}

main() {
  local DOTFILES_PATH="$(realpath "${1:-"${HOME}/dotfiles"}")"

  download
  backup
  install
  install_vim_plugins
}

main $1

#!/bin/bash

set -Ceuxo pipefail

is_mac() {
  [ "$(uname)" == 'Darwin' ]
}

is_linux() {
  [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]
}

is_ubuntu() {
  grep '^NAME="Ubuntu' /etc/os-release >/dev/null 2>&1
}

download() {
  if [ -d "${dotfiles_path}" ]; then
    echo "ngmy/dotfiles already exists in '${dotfiles_path}'"
    local yn
    read -p 'Do you want to re-download ngmy/dotfiles and continue the installation? (y/N)' yn
    if [ "${yn}" != 'y' ]; then
      echo 'The installation was canceled.'
      exit 1
    fi
    echo "Downloading ngmy/dotfiles to '${dotfiles_path}'..."
    git -C "${dotfiles_path}" pull origin master
    git -C "${dotfiles_path}" submodule update
  else
    echo "Downloading ngmy/dotfiles to '${dotfiles_path}'..."
    git clone https://github.com/ngmy/dotfiles.git "${dotfiles_path}"
    git -C "${dotfiles_path}" submodule init
    git -C "${dotfiles_path}" submodule update
  fi
}

backup() {
  local -r backup_date="$(date +%Y%m%d_%H%M%S)"
  find "${dotfiles_path}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.bashrc_ubuntu' \
    -not -name '.git' \
    -not -name '.gitconfig_linux' \
    -not -name '.gitconfig_mac' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${dotfiles_path}" ls-tree --name-only HEAD {} \
    | xargs -I {} find "${HOME}" -maxdepth 1 -name {} -not -type l \
    | xargs -I {} mv -v {} "{}.${backup_date}"
}

install() {
  find "${dotfiles_path}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.bashrc_ubuntu' \
    -not -name '.git' \
    -not -name '.gitconfig_linux' \
    -not -name '.gitconfig_mac' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${dotfiles_path}" ls-tree --name-only HEAD {} \
    | xargs -I {} ln -fnsv "${dotfiles_path}/{}" "${HOME}/{}"
  if is_ubuntu; then
    ln -fnsv "${dotfiles_path}/.bashrc_ubuntu" "${HOME}/.bashrc_os"
  fi
  if is_linux; then
    ln -fnsv "${dotfiles_path}/.gitconfig_linux" "${HOME}/.gitconfig_os"
  fi
  if is_mac; then
    ln -fnsv "${dotfiles_path}/.gitconfig_mac" "${HOME}/.gitconfig_os"
  fi
  source "${HOME}/.bash_profile"
}

install_vim_plugins() {
  vim +PlugInstall +qall
  vim '+CocInstall -sync coc-phpls coc-diagnostic coc-tsserver coc-html coc-css' +qall
}

main() {
  local -r dotfiles_path="$(realpath "${1:-"${HOME}/dotfiles"}")"

  download
  backup
  install
  install_vim_plugins
}

main "$@"

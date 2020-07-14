#!/bin/bash

DOTFILES_PATH="$(realpath "${1:-"${HOME}/dotfiles"}")"

do_it() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "ngmy/dotfiles already exists in '${DOTFILES_PATH}'"
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
  BACKUP_DATE="$(date +%Y%m%d_%H%M%S)"
  find "${DOTFILES_PATH}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.git' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${DOTFILES_PATH}" ls-tree --name-only HEAD {} \
    | xargs -I {} find "${HOME}" -maxdepth 1 -name {} -not -type l \
    | xargs -I {} mv -v {} "{}.${BACKUP_DATE}"
  find "${DOTFILES_PATH}" \
    -mindepth 1 -maxdepth 1 \
    -name '.*' \
    -not -name '.git' \
    -not -name '.gitmodules' \
    | xargs -I {} basename {} \
    | xargs -I {} git -C "${DOTFILES_PATH}" ls-tree --name-only HEAD {} \
    | xargs -I {} ln -fnsv "${DOTFILES_PATH}/{}" "${HOME}"
  source "${HOME}/.bash_profile"
  vim +PluginInstall +qall
}

do_it

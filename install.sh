#!/bin/bash

DOTFILES_PATH="${1:-"${HOME}/dotfiles"}"

do_it() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "ngmy/dotfiles already exists in '${DOTFILES_PATH}'. Skip download."
  else
    echo "Downloading ngmy/dotfiles to '${DOTFILES_PATH}'..."
    git clone https://github.com/ngmy/dotfiles.git "${DOTFILES_PATH}"
    git -C "${DOTFILES_PATH}" submodule init
    git -C "${DOTFILES_PATH}" submodule update
  fi
  find "${DOTFILES_PATH}" -name '.*' -not -name '.git' -mindepth 1 -maxdepth 1 -exec ln -nfsv {} "${HOME}" \;
  vim +PluginInstall +qall
}

do_it

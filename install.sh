#!/bin/bash

DOTFILES_PATH="${HOME}/dotfiles"

do_it() {
  if [ -d "${DOTFILES_PATH}" ]; then
    echo "ngmy/dotfiles already exists in '${DOTFILES_PATH}'. Skip download."
  else
    echo "Downloading ngmy/dotfiles to '${DOTFILES_PATH}'..."
    git clone https://github.com/ngmy/dotfiles.git "${DOTFILES_PATH}"
  fi
  find "${DOTFILES_PATH}" -name '.*' -not -name '.git' -mindepth 1 -maxdepth 1 -exec ln -nfsv {} "${HOME}" \;
}

do_it

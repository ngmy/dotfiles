# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]; then
  PATH="${PATH}:${HOME}/bin"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ]; then
  PATH="${HOME}/.local/bin:${PATH}"
fi

# set PATH so it includes Homebrew's bin if it exists
if [ -d "${HOME}/.homebrew" ]; then
  # Mac
  eval "$("${HOME}/.homebrew/bin/brew" shellenv)"
elif [ -d "${HOME}/.linuxbrew" ]; then
  # Linux
  eval "$("${HOME}/.linuxbrew/bin/brew" shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  # Linux (default prefix)
  eval "$("/home/linuxbrew/.linuxbrew/bin/brew" shellenv)"
fi

# set PATH so it includes nodebrew's bin if it exists
if [ -d "${HOME}/.nodebrew/current/bin" ]; then
  PATH="${HOME}/.nodebrew/current/bin:${PATH}"
fi

# include .bashrc if it exists
if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi

# start services if they are not started
services=(
  cron
)
for service in "${services[@]}"; do
  if ! service "${service}" status > /dev/null 2>&1; then
    echo "Firing up ${service} daemon..." >&2
    sudo service "${service}" start > /dev/null 2>&1
    if service "${service}" status > /dev/null 2>&1; then
      echo "${service} now running." >&2
    else
      echo "${service} failed to start!" >&2
    fi
  else
    echo "${service} already running." >&2
  fi
done

# set MTU to the value of the Cloudflare WARP
if ! ip link show eth0 | grep -q 1360; then
  sudo ip link set eth0 mtu 1360
  echo 'set MTU to the value of the Cloudflare WARP.'
else
  echo 'MTU already set to the value of the Cloudflare WARP.'
fi

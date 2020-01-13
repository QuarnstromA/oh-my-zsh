#!/bin/bash
HISTFILE=~/.ssh/config

if [ -n "$ZSH_VERSION" ]; then
  src=$(dirname "${(%):-%N}")/listbox/listbox.sh
elif [ -n "$BASH_VERSION" ]; then
  src=$(dirname "${BASH_SOURCE[0]}")/listbox/listbox.sh
else
  src=$(dirname "$0")/listbox/listbox.sh
fi

source "$src"

ssh-history() {
  cat $HISTFILE | grep -E "HostName" | sed 's/\s\{1\}Hostname\s\{1\}/ssh\s/' | sort | uniq -c | sort -nr 
}

ssh-connect() {
  local hist=$(ssh-history | tr '\n' '|')
  res=$(listbox -t "Connect:" -o "$hist" | tee /dev/tty | tail -n 1)
  echo ""
  echo "$res" >> "$HISTFILE"
  eval "$res"
}

#
# ~/.bash_profile
#

export PATH="$PATH:$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/linux-config/scripts"
export EDITOR="vim"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

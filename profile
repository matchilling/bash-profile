#!/bin/bash

readonly BASH_PROFILE_PATH="$HOME/.bash-profile"

export VISUAL='vim'
export EDITOR="$VISUAL"

source "$BASH_PROFILE_PATH/environment_variables.sh"
source "$BASH_PROFILE_PATH/util"
source "$BASH_PROFILE_PATH/aliases"
source "$BASH_PROFILE_PATH/path"

if [ "$(uname -s)" = "Darwin" ] ; then
  source "$BASH_PROFILE_PATH/platform/darwin.sh"
fi

if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# source client directory
if [ -d "$BASH_PROFILE_PATH/client" ]; then
  for FILE in $(find "$BASH_PROFILE_PATH/client" -type f ! -iname ".sh" | sort -z); do
    source "$FILE"
  done
fi

# completion
source "$BASH_PROFILE_PATH/completion/git.sh"
source "$BASH_PROFILE_PATH/completion/kubectl.sh"
source "$BASH_PROFILE_PATH/completion/maven.sh"
source "$BASH_PROFILE_PATH/completion/vagrant.sh"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Include git aware prompt
source "$BASH_PROFILE_PATH/lib/git_aware_prompt/main"
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

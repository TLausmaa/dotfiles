source ~/.shvars

# PATH additions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/timolausmaa/Scripts:$PATH"

# Prompt customization
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '['$branch'] '
  fi
}
COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{254}'
#COLOR_GIT=$'%F{63}'
COLOR_GIT=$'%F{255}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~ ${COLOR_GIT}$(git_branch_name)${COLOR_DEF}$ '

# Other options
setopt HIST_IGNORE_ALL_DUPS

# Aliases
alias v="nvim"
alias rr="rg"

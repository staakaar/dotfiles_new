eval "$(/opt/homebrew/bin/brew shellenv)"

umask 022
bindkey -d
bindkey -e

eval "$(/opt/homebrew/bin/brew shellenv)"
source $HOME/.local/bin/antigen.zsh
antigen use oh-my-zsh
antigen theme robbyrussell
antigen apply

#direnv setting
export EDITOR=vim
eval "$(direnv hook zsh)"

# prompt setting
export PS1='%F{165}%~ %F{039}>%F{082}>%F{196}>%f%F{255} '

# ======================Function===============================

## rprompt-git-setting
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

## memo command

memo() {
  local MEMO_DIR="$HOME/memo"
  mkdir -p "$MEMO_DIR"
  local TODAY="$(date +%Y%m%d)"

  vim "$MEMO_DIR/$TODAY.md"
}

## select history

select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$BUFFER")
  CURSOR=$#BUFFER
}

zle -N select-history
bindkey '^r' select-history

# ======================Function================================

setopt prompt_subst

export RPROMPT='`rprompt-git-current-branch`'

export LS_COLORS='no=32;40:di=34;40:ln=35:so=36:pi=33:ex=31:bd=46;34:cd=104;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls -G"
zstyle ':completion:*' list-colors "${LS_COLORS}"

#environment valiable path
eval "$(rbenv init -)"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="$HOME/go:$PATH"
export PATH="$HOME/.asdf/asdf.sh"
CGO_ENABLED=1
#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:$PATH"
export PATH="~/.rbenv/bin:$PATH"
export PATH="$PATH:/usr/local/Cellar/postgresql@14/14.6/bin/psql"
# export KERL_CONFIGURE_OPTIONS="--enable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit --with-ssl=$(brew --prefix openssl)"
export CFLAGS="-O2 -g -fno-stack-check"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export LIBRAY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export PATH="$HOME/.cargo/bin:$PATH"
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
#export PATH="/usr/local/bin/fzf:$PATH"
#export PATH="/usr/local/bin/spring:$PATH"
#export PATH="/usr/local/Cellar/node/19.4.0/bin:$PATH"
#export PATH="/usr/local:$PATH"
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home/"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home/"
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.local/bin/claude:$PATH"

#environment valiable fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPT='--preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :500 {}"'
export FZF_CTRL_R_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_R_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export FZF_ALT_C_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_ALT_C_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

## lang setting
export LANG=ja_JP.UTF-8

## cli-cmd setting
# auto change directory
setopt auto_cd

setopt auto_pushd

setopt correct

setopt list_packed

setopt noautoremoveslash

setopt nolistbeep

autoload -Uz compinit
compinit -d "$HOME/.zcompdump"

## command alias
alias ll="eza | fzf"
alias cdf="eza | fzf | xargs cd"
alias du="du -h"
alias df="df -h"
alias tree="tree -a -I '.git'"
alias .="cd ../"
alias ..="cd ../.."
alias ...="cd ../../.."
alias eza="eza -abghHliS"
alias ezt="eza --long --tree --binary --group --header --links --inode --blocks --all --level=3"
alias cat="bat"
alias catnf="cat >"

# man command
#export MANPAGER="sh -c 'col -bx | bat -l -p'"
#man 2 select

#github cli setting
# eval "$(gh completion -s zsh)"

#ripgrep alias
alias rg="rg -i"

#gh alias isuue
alias -g IS='`gh issue list | fzf | head -n 1 | cut -f1`'
alias ghi='(){gh issue view $1 -w}'

#gh alias pullrequest
alias -g PR='`gh pr list | fzf | head -n 1 | cut -f1`'
alias ghp='(){gh pr view $1 -w}'

#git alias
alias gst="git status"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gcm="git commit -m"
alias gp="git push"
alias gra="git remote add"
alias gd="git add"
alias gb="git branch"
alias gbr="git branch -r"
alias gr="git rebase"
alias gri="git log --oneline --pretty=format:'%h - %s' | fzf --preview 'git show {1} --name-only' | sed -e 's/-.*//g' | xargs  git rebase -i "
alias gpsuo="git push --set-upstream origin"
alias sw="git branch --all --format='%(refname:short)' | fzf | xargs git checkout"


# nvim
alias vim='nvim'
#alias v='vim'
# tmux alias
alias t="tmux"
#fzf alias
alias emacs="emacs -q"
alias f="fzf"
# vim default tab new
alias vp="vim -p"
#.zshrc read command alias
alias .z="source ~/.config/zsh/.zshrc"
#.vimrc read command alias
alias .v="source ~/.vimrc"
alias viz="vim ~/.config/zsh/.zshrc"
# k8s command alias
alias k="kubectl"

#npm
alias ni="npm install"
alias nu="npm uninstall"

alias vz="vim ~/.zshrc"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# eval "$(atuin init zsh)"
# if [ -f `brew --prefix`/etc/autojump ]; then
# . `brew --prefix`/etc/autojump
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
#source <(command fx --init)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f "/Users/iwamototakayuki/.ghcup/env" ] && source "/Users/iwamototakayuki/.ghcup/env" # ghcup-env
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/bin/brew:$PATH"
export PATH="/usr/local/opt/postgresql@13/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/iwamototakayuki/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/iwamototakayuki/.bun/_bun" ] && source "/Users/iwamototakayuki/.bun/_bun"

export NVM_DIR="$HOME/dotfiles/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/m4/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/kubernetes-cli@1.30/bin:$PATH"
source <(kubectl completion zsh)
export PATH="/usr/local/opt/curl/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/libarchive/lib/pkgconfig"
export PATH="/usr/local/opt/libarchive/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH=/opt/homebrew/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/libiconv/bin:/usr/local/opt/libarchive/bin:/usr/local/opt/libarchive/bin:/usr/local/opt/llvm@19/bin:/Users/iwamototakayuki/.bun/bin:/usr/local/opt/curl/bin:/usr/local/opt/kubernetes-cli@1.30/bin:/usr/local/opt/libpq/bin:/usr/local/opt/curl/bin:/usr/local/opt/m4/bin:/Users/iwamototakayuki/dotfiles/.config/nvm/versions/node/v20.17.0/bin:/Users/iwamototakayuki/.rd/bin:/usr/local/opt/postgresql@13/bin:/opt/homebrew/bin/brew:/usr/local/opt/ruby/bin:/Users/iwamototakayuki/.pyenv/shims:/Users/iwamototakayuki/.volta/bin:/Users/iwamototakayuki/.rd/bin:/Users/iwamototakayuki/.deno/bin:/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home//bin:/usr/local:/usr/local/Cellar/node/19.4.0/bin:/usr/local/bin/spring:/usr/local/bin/fzf:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/iwamototakayuki/.cargo/bin:/usr/local/opt/mysql@5.7/bin:/usr/local/opt/openssl@1.1/bin:~/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/Users/iwamototakayuki/.asdf/asdf.sh:/usr/local/Cellar/postgresql@14/14.6/bin/psql:/Users/iwamototakayuki/go/bin:/.local/bin/claude
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@19/bin:$PATH"
export PATH="$(brew --prefix llvm@19)/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export MINIO_CONFIG_ENV_FILE=/etc/default/minio
export S3_R2_ACCESS_KEY=0e7dd629c8057a833537a5ec16874391
export S3_R2_ENDPOINT=https://5853eec0465aff9a7034c3d4e7626a3d.r2.cloudflarestorage.com
export S3_R2_BUCKET=bun-test
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="./build/debug:$PATH"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

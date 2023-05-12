bind \t accept-autosuggestion

set BUN_INSTALL "$HOME/.bun"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
set -gx DENO_INSTALL $HOME/.deno
set -gx FNM_HOME $HOME/.local/share/fnm
set -gx PATH "$FNM_HOME" $PATH
set PATH $BUN_INSTALL/bin $DENO_INSTALL/bin $HOME/.ghcup/bin $HOME/.cargo/bin $HOME/.local/share/bob/nvim-bin $HOME/bin $HOME/racket/bin $HOME/.config/emacs/bin $HOME/.nimble/bin $HOME/.local/bin $HOME/go/bin $HOME/.cabal/bin $PATH

# use bat for manpaging, to get colors
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# set this to correct artifacts
set -x MANROFFOPT -c

set -gx EDITOR nvim
set -gx GIT_EDITOR $EDITOR

set RATIONAL_EMACS_HOME $HOME/Code/rational-emacs

alias clj="rlwrap clojure"
alias open=xdg-open
alias rm=trash
alias rusti=evcxr

# can't read dircolors files directly, so ...
set -gx LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
# set notification of complete process to sound
set -U __done_notify_sound 1

# https://gist.github.com/lonsun/23df675f631f38f942be53bf4fe28570
function git_clean_branches
    set base_branch main

    # work from our base branch
    git checkout $base_branch

    # remove local tracking branches where the remote branch is gone
    git fetch -p

    # find all local branches that have been merged into the base branch
    # and delete any without a corresponding remote branch
    set local
    for f in (git branch --merged $base_branch | grep -v "\(master\|$base_branch\|\*\)" | awk '/\s*\w*\s*/ {print $1}')
        set local $local $f
    end

    set remote
    for f in (git branch -r | xargs basename)
        set remote $remote $f
    end

    for f in $local
        echo $remote | grep --quiet "\s$f\s"
        if [ $status -gt 0 ]
            git branch -d $f
        end
    end
end

alias config='/usr/bin/git --git-dir=/home/bruce/.cfg/ --work-tree=/home/bruce'

# opam configuration
source /home/bruce/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

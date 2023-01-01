## Environment setup
# Apply .profile
source ~/.profile

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

fish_add_path -P ~/.npm-global/bin
fish_add_path -P ~/.deno/bin

# Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Enable starship
starship init fish | source

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Useful aliases
# Make rm prompt when removing more than 3 files
alias rm='rm -I'

# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'" # show only dotfiles

# Replace cat with bat
alias cat='bat --style header --style rule --style snip --style changes --style header'

alias icat="kitty +kitten icat"

alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias wget='wget -c '
alias update-mirror='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist'
alias upd='paru -Syu && fish_update_completions && sudo updatedb && pacdiff -s'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias hw='hwinfo --short'
alias lsgitpkg='pacman -Q | grep -i "\-git"'
alias rmorphpkgs='sudo pacman -Rns (pacman -Qtdq)'
alias paccleanup='paccache -rvk2'
alias sudoedit='sudo -e'
alias p='paru'

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/home/tommy/.config/netlify/helper/path.fish.inc' && source '/home/tommy/.config/netlify/helper/path.fish.inc'

# Enable thefuck
thefuck --alias | source


#############################################################
###### Output Colorization ##################################
#############################################################
alias diff='diff --color=auto'
alias radeontop='radeontop -c'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## Cope colorization
set -l cope_script_path /usr/share/perl5/vendor_perl/auto/share/dist/Cope/

for i in blkid free ifconfig lspci lsusb mount ps traceroute wget sha1sum sha256sum sha384sum sha512sum shasum
    alias $i="$cope_script_path/$i"
end


# Make Flatpak work, see: https://forum.endeavouros.com/t/make-flatpak-work-if-you-use-fish-shell/14196
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end


# Enable the usage of 'sudo!!'
function sudo!!
    eval sudo $history[1]
end

# Enable Dracula theme to work in Micro
export MICRO_TRUECOLOR=1

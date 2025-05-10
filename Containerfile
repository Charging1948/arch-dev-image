FROM ghcr.io/ublue-os/arch-toolbox:latest


COPY system_files /


RUN pacman -S systemd git tmux nodejs neovim rustup bat devtools grc fastfetch kwallet uv python python-pip python-pipx fd ripgrep --noconfirm


RUN paru -S aur/windsurf aur/rstudio-desktop aur/icaclient --noconfirm --skipreview



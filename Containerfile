FROM ghcr.io/ublue-os/arch-toolbox:latest as toolbox

# Add distrobox label
LABEL com.github.containers.toolbox="true"

COPY system_files /

RUN pacman -S --noconfirm systemd git tmux nodejs neovim rustup bat devtools grc fastfetch kwallet uv python python-pip python-pipx fd ripgrep

# Create a temporary build user
RUN useradd -m -s /bin/bash builduser && \
	echo "builduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to build user
USER builduser
WORKDIR /home/builduser

# Install AUR packages using paru
RUN paru -S --noconfirm --skipreview \
	windsurf icaclient

# Clean up package cache to reduce image size
RUN paru -Scc --noconfirm || true

# Switch back to root
USER root

# Remove the build user AND the sudoers entry
RUN userdel -r builduser && \
	sed -i '/^builduser/d' /etc/sudoers

# Clean up package cache to reduce image size
RUN pacman -Scc --noconfirm


ENV EDITOR=nvim


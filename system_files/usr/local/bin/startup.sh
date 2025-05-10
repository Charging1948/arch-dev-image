#!/usr/bin/env bash

echo -e "Starting initialization process\n"

echo -e "Ensuring Citrix-Workspace has correct setup"
mkdir -p ~/.ICAClient/cache
cp /opt/Citrix/ICAClient/config/{All_Regions,Trusted_Region,Unknown_Region,canonicalization,regions}.ini ~/.ICAClient/

echo -e "Finished Citrix-Workspace setup.\n"

echo -e "Setting up nix."

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

nix run nixpkgs#home-manager -- switch --flake /home/jk/code/nix/denix-flake

echo -e "\n\n\nInitial setup complete. Enjoy your new system!"

#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
# set -oue pipefail
set -ouex pipefail

# Your code goes here.
# echo 'This is an example shell script'
# echo 'Scripts here will run during build if specified in recipe.yml'
echo 'Setup Script'

# Starship Shell Prompt
curl -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/starship.tar.gz -C /tmp
install -c -m 0755 /tmp/starship /usr/bin
# shellcheck disable=SC2016
echo 'eval "$(starship init bash)"' >> /etc/bashrc
echo 'export PATH=$PATH:/usr/share/setup-scripts' >> /etc/bashrc
chmod a+x /usr/share/setup-scripts/sysctl-manager
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/share/setup-scripts
#echo 'uname -a' >> /etc/bashrc
rpm-ostree install fastfetch tmux tree \
	fzf gum \
	distrobox vim grim dunst \
	cockpit cockpit-files cockpit-machines cockpit-networkmanager \
	cockpit-ostree cockpit-podman cockpit-selinux cockpit-storaged cockpit-system  \
	micro hyprland hyprpaper firefox NetworkManager network-manager-applet waybar mpv dolphin lynis spice-vdagent 
# hyprctl
#      - xdg-desktop-portal-hyprland
#      - alacritty
#      - sddm
	# just \

#echo 'fastfetch' >> /etc/bashrc


echo Done

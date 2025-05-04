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
#echo 'uname -a' >> /etc/bashrc
# cockpit and extensions
rpm-ostree install fastfetch
echo 'fastfetch' >> /etc/bashrc


echo Done

alias b := help
 
host := `uname -a`

# build main
help:
    echo "Pasos para actualizar el sistema"
    echo "  sysctl-manager rebase1"
    echo "  systemctl reboot"
    echo "  sysctl-manager rebase2"
    echo "  systemctl reboot"

test TEST1F:
    ls {{TEST1F}}
    echo FIN!      

rebase1:
    echo "rpm-ostree rebase ostree-unverified-registry:ghcr.io/jbanuls13/mess1-os:latest"

rebase2:
    echo "rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jbanuls13/mess1-os:latest"

update:
    echo "Actualizando sistema"
    rpm-ostree update

hyprconfig:
    cp /usr/share/setup-scripts/config $HOME/.config

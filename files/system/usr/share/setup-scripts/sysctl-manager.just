alias b := help
 
host := `uname -a`

# build main
help:
    @echo "Pasos para actualizar el sistema"
    @echo "  sysctl-manager rebase1"
    @echo "  systemctl reboot"
    @echo "  sysctl-manager rebase2"
    @echo "  systemctl reboot"

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
    cp -r /usr/share/setup-scripts/config $HOME/.config

add-zellij:
    /usr/share/setup-scripts/install_zellij.sh

add-admin-usr:
    sudo useradd -m -G wheel -s /bin/bash admin
    sudo passwd admin

del-video-service:
    sudo userdel gerbera
    sudo rm -rf /var/home/gerbera
    echo "Falta eliminar servicio systemd"

add-video-service:
    sudo useradd -m -s /sbin/nologin gerbera
    sudo mkdir -p /var/home/gerbera/.config/systemd/user
    sudo cp /usr/share/setup-scripts/servicios/container-gerbera.service /var/home/gerbera/.config/systemd/user
    sudo chown -R gerbera:gerbera /var/home/gerbera/
    sudo -u gerbera systemctl --user enable container-gerbera.service
    sudo -u gerbera systemctl --user daemon-reload
    sudo -u gerbera systemctl --user start container-gerbera.service 

pending:
    echo "buddybox"

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
    cp -r /usr/share/setup-scripts/config/hypr /usr/share/setup-scripts/config/waybar $HOME/.config

add-zellij:
    /usr/share/setup-scripts/install_zellij.sh

add-admin-usr:
    sudo useradd -m -G wheel -s /bin/bash admin
    sudo passwd admin

del-video-service:
    sudo loginctl disable-linger gerbera
    sudo userdel -r gerbera
    echo "Falta eliminar servicio systemd"

add-video-service:
    #sudo useradd -m -s /sbin/nologin gerbera
    #sudo systemctl disable user@1007
    sudo loginctl disable-linger gerbera
    sudo userdel -r gerbera
    sudo useradd -m -s /bin/bash gerbera
    sudo passwd gerbera
    sudo mkdir -p /var/home/gerbera/.config/systemd/user
    sudo mkdir -p /var/home/gerbera/photos
    sudo cp /usr/share/setup-scripts/servicios/container-gerbera.service /var/home/gerbera/.config/systemd/user
    sudo chown -R gerbera:gerbera /var/home/gerbera/
    sudo loginctl enable-linger gerbera
    sudo -u gerbera podman pull docker.io/gerbera/gerbera:2.5.0
    sudo -u gerbera systemctl --user enable container-gerbera.service
    sudo -u gerbera systemctl --user start container-gerbera.service 

    #sudo loginctl enable-linger gerbera
    #sudo runuser -l gerbera -c 'dbus-launch systemctl --user enable container-gerbera.service'
    #export XDG_RUNTIME_DIR=/run/user/$(id -u gerbera)
    #export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

pending:
    echo "buddybox"

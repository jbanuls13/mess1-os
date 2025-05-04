alias b := help
 
host := `uname -a`

# build main
help:
    {{host}}
    echo "Pasos para actualizar el sistema"
    echo "  sysctl-manager rebase1"
    echo "  systemctl reboot"
    echo "  sysctl-manager rebase2"
    echo "  systemctl reboot"

test TEST1F:
    ls {{TEST1F}}
    echo FIN!      

rebase1:
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/jbanuls13/mess1-os:latest

rebase2:
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jbanuls13/mess1-os:latest

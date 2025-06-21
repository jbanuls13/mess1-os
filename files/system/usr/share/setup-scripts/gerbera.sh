#!/bin/bash

USERNAME="mediauser"
CONTAINER_NAME="gerbera"
SERVICE_NAME="gerbera-container"

# 1. Create the user without shell login
useradd --create-home --shell /usr/sbin/nologin "$USERNAME"

# 2. Enable lingering so the user’s systemd services can run
loginctl enable-linger "$USERNAME"

# 3. Create systemd user service for Podman
USER_SERVICE_PATH="/home/$USERNAME/.config/systemd/user"
mkdir -p "$USER_SERVICE_PATH"

cat > "$USER_SERVICE_PATH/${SERVICE_NAME}.service" <<EOF
[Unit]
Description=Gerbera Media Server Container
After=network.target

[Service]
Restart=always
ExecStart=/usr/bin/podman run --rm --name $CONTAINER_NAME -p 49152:49152 -v /home/$USERNAME/media:/media:Z ghcr.io/gerbera/gerbera
ExecStop=/usr/bin/podman stop $CONTAINER_NAME

[Install]
WantedBy=default.target
EOF

# 4. Set correct permissions
chown -R "$USERNAME":"$USERNAME" "/home/$USERNAME/.config"

# 5. Start and enable the service in user scope
runuser -l "$USERNAME" -c "systemctl --user daemon-reexec"
runuser -l "$USERNAME" -c "systemctl --user daemon-reload"
runuser -l "$USERNAME" -c "systemctl --user enable --now ${SERVICE_NAME}.service"


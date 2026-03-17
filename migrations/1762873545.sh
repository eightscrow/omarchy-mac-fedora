echo "Switch Elephant to run as a systemd service and walker to be autostarted on login"

pkill elephant || true

if command -v elephant >/dev/null 2>&1; then
  elephant service enable || true

  mkdir -p ~/.config/systemd/user/elephant.service.d

  cat > ~/.config/systemd/user/elephant.service.d/20-exec.conf <<EOF
[Service]
ExecStart=
ExecStart=$HOME/.local/bin/elephant
EOF

  cat > ~/.config/systemd/user/elephant.service.d/30-path.conf <<EOF
[Service]
Environment=PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin
EOF

  systemctl --user daemon-reload
  systemctl --user restart elephant.service || systemctl --user start elephant.service
fi

pkill walker || true
mkdir -p ~/.config/autostart/
cp "$OMARCHY_PATH/default/walker/walker.desktop" ~/.config/autostart/

if command -v walker >/dev/null 2>&1; then
  setsid walker --gapplication-service >/dev/null 2>&1 &
fi

#!/bin/bash

# Configure Walker + Elephant integration and refresh runtime files.
mkdir -p ~/.config/elephant/menus
ln -snf "$OMARCHY_PATH/default/elephant/omarchy_themes.lua" ~/.config/elephant/menus/omarchy_themes.lua
ln -snf "$OMARCHY_PATH/default/elephant/omarchy_background_selector.lua" ~/.config/elephant/menus/omarchy_background_selector.lua

mkdir -p ~/.config/systemd/user/elephant.service.d
cat >~/.config/systemd/user/elephant.service.d/10-omarchy-path.conf <<EOF
[Service]
Environment=OMARCHY_PATH=$OMARCHY_PATH
EOF

if command -v omarchy-refresh-walker >/dev/null 2>&1; then
  omarchy-refresh-walker || true
fi

if command -v elephant >/dev/null 2>&1; then
  elephant service enable || true
fi

#!/bin/bash

# Manus Monitor Widget Uninstallation Script

WIDGET_NAME="com.github.jamiefmarra.manusmonitor"
WIDGET_DIR="$HOME/.local/share/plasma/plasmoids/$WIDGET_NAME"

echo "Uninstalling Manus Monitor Widget..."

if [ -d "$WIDGET_DIR" ]; then
    rm -rf "$WIDGET_DIR"
    echo "Widget uninstalled successfully!"
    echo ""
    echo "Note: You may need to restart Plasma to complete the removal:"
    echo "  kquitapp5 plasmashell && kstart5 plasmashell"
else
    echo "Widget is not installed."
fi

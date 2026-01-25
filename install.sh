#!/bin/bash

# Manus Monitor Widget Installation Script

WIDGET_NAME="com.github.jamiefmarra.manusmonitor"
WIDGET_DIR="$HOME/.local/share/plasma/plasmoids/$WIDGET_NAME"

echo "Installing Manus Monitor Widget..."

# Create plasmoids directory if it doesn't exist
mkdir -p "$HOME/.local/share/plasma/plasmoids"

# Copy widget files
echo "Copying widget files..."
cp -r "$WIDGET_NAME" "$WIDGET_DIR"

echo "Widget installed successfully!"
echo ""
echo "To use the widget:"
echo "1. Right-click on your desktop or panel"
echo "2. Select 'Add Widgets...'"
echo "3. Search for 'Manus Monitor'"
echo "4. Add the widget to your desktop or panel"
echo "5. Right-click the widget and select 'Configure' to enter your API key"
echo ""
echo "Note: You'll need a Manus API key from https://manus.im"

#!/bin/bash
# Manus Monitor Widget - Diagnostic Script

WIDGET_NAME="com.github.jamiefmarra.manusmonitor"
WIDGET_DIR="$HOME/.local/share/plasma/plasmoids/$WIDGET_NAME"

echo "========================================"
echo "Manus Monitor Widget - Diagnostics"
echo "========================================"
echo ""

# Check if widget directory exists
echo "1. Checking widget installation..."
if [ -d "$WIDGET_DIR" ]; then
    echo "   ✓ Widget directory exists: $WIDGET_DIR"
else
    echo "   ✗ Widget directory NOT found: $WIDGET_DIR"
    echo "   Please run ./install.sh first"
    exit 1
fi

# Check metadata.json
echo ""
echo "2. Checking metadata.json..."
if [ -f "$WIDGET_DIR/metadata.json" ]; then
    echo "   ✓ metadata.json exists"
    echo "   Content:"
    cat "$WIDGET_DIR/metadata.json" | head -20
else
    echo "   ✗ metadata.json NOT found"
fi

# Check main.qml
echo ""
echo "3. Checking main.qml..."
if [ -f "$WIDGET_DIR/contents/ui/main.qml" ]; then
    echo "   ✓ main.qml exists"
    LINES=$(wc -l < "$WIDGET_DIR/contents/ui/main.qml")
    echo "   Lines: $LINES"
else
    echo "   ✗ main.qml NOT found"
fi

# Check main.xml
echo ""
echo "4. Checking main.xml..."
if [ -f "$WIDGET_DIR/contents/config/main.xml" ]; then
    echo "   ✓ main.xml exists"
else
    echo "   ✗ main.xml NOT found"
fi

# Check file permissions
echo ""
echo "5. Checking file permissions..."
ls -la "$WIDGET_DIR" | head -10

# Check if widget is recognized by Plasma
echo ""
echo "6. Checking Plasma widget cache..."
CACHE_DIR="$HOME/.cache/plasmashell"
if [ -d "$CACHE_DIR" ]; then
    echo "   ✓ Plasma cache directory exists"
    echo "   Clearing cache to force reload..."
    rm -rf "$CACHE_DIR"/*
    echo "   ✓ Cache cleared"
else
    echo "   ✗ Plasma cache directory not found"
fi

# Check KPackage
echo ""
echo "7. Checking KPackage installation..."
if command -v kpackagetool6 &> /dev/null; then
    echo "   ✓ kpackagetool6 found"
    echo "   Listing installed plasmoids:"
    kpackagetool6 --type=Plasma/Applet --list | grep -i manus || echo "   ✗ Manus Monitor not found in KPackage list"
else
    echo "   ✗ kpackagetool6 not found"
fi

echo ""
echo "========================================"
echo "Diagnostic complete"
echo "========================================"
echo ""
echo "RECOMMENDED ACTIONS:"
echo "1. Run: kquitapp6 plasmashell && kstart6 plasmashell"
echo "2. Try adding the widget again"
echo "3. If still not working, run: ./fix-widget.sh"
echo ""

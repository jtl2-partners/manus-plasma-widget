#!/bin/bash
# Manus Monitor Widget - Fix and Reinstall Script

WIDGET_NAME="com.github.jamiefmarra.manusmonitor"
WIDGET_DIR="$HOME/.local/share/plasma/plasmoids/$WIDGET_NAME"

echo "========================================"
echo "Manus Monitor Widget - Fix Script"
echo "========================================"
echo ""

# Step 1: Remove existing installation
echo "1. Removing existing widget installation..."
if [ -d "$WIDGET_DIR" ]; then
    rm -rf "$WIDGET_DIR"
    echo "   ✓ Removed old installation"
else
    echo "   ℹ No existing installation found"
fi

# Step 2: Clear Plasma cache
echo ""
echo "2. Clearing Plasma cache..."
CACHE_DIR="$HOME/.cache/plasmashell"
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"/*
    echo "   ✓ Cache cleared"
fi

# Step 3: Clear KPackage cache
echo ""
echo "3. Clearing KPackage cache..."
KPACKAGE_CACHE="$HOME/.cache/kpackage"
if [ -d "$KPACKAGE_CACHE" ]; then
    rm -rf "$KPACKAGE_CACHE"/*
    echo "   ✓ KPackage cache cleared"
fi

# Step 4: Reinstall widget
echo ""
echo "4. Installing widget..."
mkdir -p "$HOME/.local/share/plasma/plasmoids"
cp -r "$WIDGET_NAME" "$WIDGET_DIR"
echo "   ✓ Widget files copied"

# Step 5: Set proper permissions
echo ""
echo "5. Setting file permissions..."
chmod -R 755 "$WIDGET_DIR"
find "$WIDGET_DIR" -type f -exec chmod 644 {} \;
echo "   ✓ Permissions set"

# Step 6: Verify installation
echo ""
echo "6. Verifying installation..."
if [ -f "$WIDGET_DIR/metadata.json" ]; then
    echo "   ✓ metadata.json present"
fi
if [ -f "$WIDGET_DIR/contents/ui/main.qml" ]; then
    echo "   ✓ main.qml present"
fi
if [ -f "$WIDGET_DIR/contents/config/main.xml" ]; then
    echo "   ✓ main.xml present"
fi

# Step 7: Try using kpackagetool6
echo ""
echo "7. Attempting KPackage installation..."
if command -v kpackagetool6 &> /dev/null; then
    echo "   Uninstalling via kpackagetool6 (if exists)..."
    kpackagetool6 --type=Plasma/Applet --remove "$WIDGET_NAME" 2>/dev/null || true
    
    echo "   Installing via kpackagetool6..."
    kpackagetool6 --type=Plasma/Applet --install "$WIDGET_NAME" 2>&1 || \
    kpackagetool6 --type=Plasma/Applet --upgrade "$WIDGET_NAME" 2>&1 || \
    echo "   ℹ Manual installation completed (kpackagetool6 not required)"
else
    echo "   ℹ kpackagetool6 not available, using manual installation"
fi

echo ""
echo "========================================"
echo "Fix complete!"
echo "========================================"
echo ""
echo "NEXT STEPS:"
echo "1. Restart Plasma Shell:"
echo "   kquitapp6 plasmashell && kstart6 plasmashell"
echo ""
echo "2. Add the widget:"
echo "   - Right-click desktop → Add Widgets"
echo "   - Search for 'Manus Monitor'"
echo "   - Drag to desktop or panel"
echo ""
echo "If you still have issues:"
echo "- Check: journalctl -f | grep plasmashell"
echo "- Look for any error messages"
echo ""

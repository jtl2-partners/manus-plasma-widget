# Manus Monitor Widget - Troubleshooting Guide

## Issue: Widget Appears in List But Cannot Be Dragged to Desktop

This is a common issue with KDE Plasma widgets. Here are the solutions:

---

## Solution 1: Use the Fix Script (Recommended)

We've created an automated fix script that resolves most issues:

```bash
cd manus-plasma-widget
chmod +x fix-widget.sh
./fix-widget.sh
```

Then restart Plasma:
```bash
kquitapp6 plasmashell && kstart6 plasmashell
```

---

## Solution 2: Manual Installation via KPackage

If the fix script doesn't work, try installing via KPackage tool:

```bash
cd manus-plasma-widget
kpackagetool6 --type=Plasma/Applet --install com.github.jamiefmarra.manusmonitor
```

If you get an "already installed" error:
```bash
kpackagetool6 --type=Plasma/Applet --upgrade com.github.jamiefmarra.manusmonitor
```

Then restart Plasma:
```bash
kquitapp6 plasmashell && kstart6 plasmashell
```

---

## Solution 3: Clear All Caches

Sometimes Plasma caches prevent widgets from loading properly:

```bash
# Clear Plasma cache
rm -rf ~/.cache/plasmashell/*

# Clear KPackage cache
rm -rf ~/.cache/kpackage/*

# Clear icon cache
rm -rf ~/.cache/icon-cache.kcache

# Restart Plasma
kquitapp6 plasmashell && kstart6 plasmashell
```

---

## Solution 4: Check Widget Structure

Run the diagnostic script to verify installation:

```bash
cd manus-plasma-widget
chmod +x diagnose.sh
./diagnose.sh
```

The diagnostic will check:
- Widget directory exists
- All required files present
- File permissions correct
- Plasma recognizes the widget

---

## Solution 5: Alternative Adding Methods

If dragging doesn't work, try these alternative methods:

### Method A: Right-Click Add
1. Right-click on desktop
2. Select "Add Widgets..."
3. Find "Manus Monitor"
4. **Click** on it (don't drag)
5. It should appear on your desktop

### Method B: Panel Add
1. Right-click on your panel
2. Select "Add Widgets..."
3. Find "Manus Monitor"
4. Click to add to panel

### Method C: Desktop Settings
1. Right-click desktop → "Configure Desktop and Wallpaper"
2. Go to "Widgets" tab
3. Click "Add Widgets"
4. Find and add "Manus Monitor"

---

## Common Error Messages

### Error: "Package already installed"

**Solution:**
```bash
kpackagetool6 --type=Plasma/Applet --remove com.github.jamiefmarra.manusmonitor
kpackagetool6 --type=Plasma/Applet --install com.github.jamiefmarra.manusmonitor
```

### Error: "Could not find a suitable installer"

**Solution:** Use manual installation:
```bash
./install.sh
```

### Error: Widget shows but is blank/empty

**Solution:** Check API key configuration:
1. Right-click widget → Configure
2. Enter your Manus API key
3. Click Apply

---

## Checking Logs for Errors

If the widget still doesn't work, check Plasma logs:

```bash
journalctl -f | grep plasmashell
```

Look for errors related to "manusmonitor" or "Manus Monitor"

Common errors and solutions:

**Error:** "QML Component: Component is not ready"
- **Solution:** Missing QML file, run `./fix-widget.sh`

**Error:** "Cannot assign to non-existent property"
- **Solution:** Configuration issue, delete `~/.config/plasma-org.kde.plasma.desktop-appletsrc` and reconfigure

**Error:** "Failed to load QML file"
- **Solution:** Syntax error in QML, reinstall widget

---

## Verifying Installation

Check if widget files are in the correct location:

```bash
ls -la ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor/
```

You should see:
```
contents/
├── config/
│   ├── config.qml
│   └── main.xml
└── ui/
    ├── configAlerts.qml
    ├── configDisplay.qml
    ├── configGeneral.qml
    └── main.qml
metadata.json
```

---

## System Requirements Check

Ensure you have the minimum requirements:

```bash
# Check KDE Plasma version
plasmashell --version

# Check Qt version
qmake --version

# Check if required tools are installed
which kpackagetool6
which kquitapp6
which kstart6
```

**Minimum versions:**
- KDE Plasma: 6.0+
- Qt: 6.0+

---

## Desktop vs Panel Mode

The widget works in both desktop and panel modes:

**Desktop Mode:**
- Full widget with all features
- Scrollable content
- Recommended size: 30×40 grid units

**Panel Mode:**
- Compact icon with status indicators
- Click to expand full view
- Minimal space usage

If one mode doesn't work, try the other.

---

## Permissions Issues

If you get permission errors:

```bash
cd manus-plasma-widget
chmod -R 755 com.github.jamiefmarra.manusmonitor/
find com.github.jamiefmarra.manusmonitor/ -type f -exec chmod 644 {} \;
./install.sh
```

---

## Complete Reinstall

If nothing else works, do a complete clean reinstall:

```bash
# 1. Remove widget from desktop/panel
# 2. Uninstall completely
./uninstall.sh
kpackagetool6 --type=Plasma/Applet --remove com.github.jamiefmarra.manusmonitor

# 3. Clear all caches
rm -rf ~/.cache/plasmashell/*
rm -rf ~/.cache/kpackage/*
rm -rf ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor

# 4. Reinstall
./fix-widget.sh

# 5. Restart Plasma
kquitapp6 plasmashell && kstart6 plasmashell

# 6. Try adding widget again
```

---

## Still Not Working?

If you've tried everything above and the widget still doesn't work:

1. **Check system logs:**
   ```bash
   journalctl -xe | grep -i plasma
   ```

2. **Verify QML syntax:**
   ```bash
   qmlscene ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor/contents/ui/main.qml
   ```

3. **Test in plasmoidviewer:**
   ```bash
   plasmoidviewer -a com.github.jamiefmarra.manusmonitor
   ```

4. **Report the issue:**
   - GitHub: https://github.com/jamiefmarra/manus-plasma-widget/issues
   - Include: KDE version, Qt version, error logs

---

## Quick Reference Commands

```bash
# Diagnose
./diagnose.sh

# Fix and reinstall
./fix-widget.sh

# Restart Plasma
kquitapp6 plasmashell && kstart6 plasmashell

# Check logs
journalctl -f | grep plasmashell

# Manual install via KPackage
kpackagetool6 --type=Plasma/Applet --install com.github.jamiefmarra.manusmonitor

# Manual uninstall via KPackage
kpackagetool6 --type=Plasma/Applet --remove com.github.jamiefmarra.manusmonitor

# List installed widgets
kpackagetool6 --type=Plasma/Applet --list | grep -i manus
```

---

## Success Indicators

You'll know the widget is working when:

✅ Widget appears in "Add Widgets" list  
✅ Widget can be dragged to desktop  
✅ Widget shows health status and metrics  
✅ Network indicator pulses during API calls  
✅ Configuration dialog opens and saves settings  
✅ No errors in `journalctl` logs  

---

## Additional Help

- **Documentation:** See README.md for full feature list
- **GitHub:** https://github.com/jamiefmarra/manus-plasma-widget
- **Issues:** https://github.com/jamiefmarra/manus-plasma-widget/issues

---

**Last Updated:** January 25, 2026  
**Version:** 2.0.0

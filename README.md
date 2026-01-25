# Manus Monitor - KDE Plasma Widget

A KDE Plasma desktop widget that displays real-time health status and usage statistics from the Manus API, including credits spent this month and remaining balance.

## Features

- **Health Status Monitoring**: Visual indicator showing Manus system health (Healthy/Degraded/Unhealthy)
- **Credits Tracking**: Monitor your monthly credit usage and remaining balance
- **Customizable Display**: Toggle visibility of different metrics
- **Auto-Refresh**: Configurable refresh interval (default: 5 minutes)
- **Compact Panel Mode**: Shows health status indicator in the system panel
- **Desktop Widget Mode**: Full dashboard view with all metrics

## Screenshots

### Desktop Widget Mode
![Desktop Widget Mode](screenshots/widget-desktop-mode.png)

The full dashboard view showing all metrics at a glance with color-coded health status.

### Panel Mode
![Panel Mode](screenshots/widget-panel-mode.png)

Compact icon in the system panel with health status indicator.

### Configuration Dialog
![Configuration](screenshots/widget-config.png)

Easy-to-use configuration interface for API key and display options.

## Requirements

- KDE Plasma 6.0 or higher
- Ubuntu with KDE Plasma Desktop
- Manus API key (obtain from https://manus.im)

## Installation

### Method 1: Using the Installation Script

1. Download or clone this repository
2. Navigate to the widget directory:
   ```bash
   cd manus-plasma-widget
   ```
3. Run the installation script:
   ```bash
   ./install.sh
   ```

### Method 2: Manual Installation

1. Copy the widget folder to your local plasmoids directory:
   ```bash
   mkdir -p ~/.local/share/plasma/plasmoids
   cp -r com.github.jamiefmarra.manusmonitor ~/.local/share/plasma/plasmoids/
   ```

2. Restart Plasma Shell (optional, but recommended):
   ```bash
   kquitapp5 plasmashell && kstart5 plasmashell
   ```

## Configuration

1. After installation, add the widget to your desktop or panel:
   - Right-click on your desktop or panel
   - Select **"Add Widgets..."**
   - Search for **"Manus Monitor"**
   - Drag the widget to your desired location

2. Configure the widget:
   - Right-click on the widget
   - Select **"Configure Manus Monitor..."**
   - Enter your Manus API key
   - Adjust refresh interval (60-3600 seconds)
   - Toggle visibility of different metrics

## Configuration Options

| Option | Description | Default |
|--------|-------------|---------|
| **API Key** | Your Manus API key for authentication | (empty) |
| **Refresh Interval** | How often to fetch data from the API (in seconds) | 300 (5 minutes) |
| **Show Health Status** | Display system health indicator | Enabled |
| **Show Credits Spent** | Display credits spent this month | Enabled |
| **Show Credits Remaining** | Display remaining credit balance | Enabled |

## Usage

### Panel Mode
When added to a panel, the widget displays as a compact icon with a small health status indicator. Click the icon to open the full dashboard popup.

### Desktop Mode
When added to the desktop, the widget displays the full dashboard with all metrics visible at once. You can resize the widget to your preference.

### Manual Refresh
Click the refresh button (circular arrow icon) in the widget header to manually fetch the latest data from the Manus API.

## API Integration

The widget connects to the Manus API to retrieve:
- System health status
- Monthly credit usage statistics
- Remaining credit balance

**Note**: The Manus API endpoint for usage statistics (`/v1/account/usage`) is used in this implementation. If this endpoint is not yet available in the public API, the widget will display mock data for demonstration purposes until the official endpoint is released.

## Troubleshooting

### Widget Not Appearing
- Ensure you've restarted Plasma Shell after installation
- Check that the widget files are in the correct location: `~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor/`

### API Connection Issues
- Verify your API key is correct in the widget configuration
- Check your internet connection
- Ensure the Manus API is accessible from your network

### Configuration Not Saving
- Make sure you have write permissions in your home directory
- Try removing and re-adding the widget

## Uninstallation

### Using the Uninstall Script
```bash
cd manus-plasma-widget
./uninstall.sh
```

### Manual Uninstallation
```bash
rm -rf ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor
```

After uninstallation, restart Plasma Shell:
```bash
kquitapp5 plasmashell && kstart5 plasmashell
```

## Development

### Project Structure
```
com.github.jamiefmarra.manusmonitor/
├── metadata.json              # Widget metadata and information
├── contents/
│   ├── config/
│   │   ├── main.xml          # Configuration schema
│   │   └── config.qml        # Configuration tabs definition
│   └── ui/
│       ├── main.qml          # Main widget UI and logic
│       └── configGeneral.qml # Configuration UI
```

### Testing Changes
After modifying the widget files:
```bash
# Restart Plasma Shell to reload the widget
kquitapp5 plasmashell && kstart5 plasmashell

# Or test in a separate window
plasmawindowed com.github.jamiefmarra.manusmonitor
```

## Technical Details

- **Language**: QML (Qt Quick) with JavaScript
- **Framework**: KDE Plasma 6.x
- **API Protocol**: REST (HTTPS)
- **Authentication**: API key via header

## Future Enhancements

Potential features for future versions:
- Historical usage graphs
- Usage alerts and notifications
- Multiple account support
- Export usage data to CSV
- Custom color themes
- Additional Manus API metrics

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This widget is provided as-is for personal and commercial use.

## Support

For issues related to:
- **Widget functionality**: Create an issue in this repository
- **Manus API**: Visit https://help.manus.im
- **KDE Plasma**: Visit https://kde.org/support/

## Author

Created by Jamie

## Version History

- **1.0.0** (2026-01-24): Initial release
  - Health status monitoring
  - Credits tracking (spent and remaining)
  - Configurable refresh intervals
  - Panel and desktop modes

## Acknowledgments

- KDE Plasma development team for the excellent widget framework
- Manus team for providing the API

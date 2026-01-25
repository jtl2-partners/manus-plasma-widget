# Manus Monitor - KDE Plasma Widget

A comprehensive KDE Plasma desktop widget for monitoring Manus API health, usage statistics, and task analytics in real-time.

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![KDE Plasma](https://img.shields.io/badge/KDE%20Plasma-6-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

### 🎯 Core Metrics
- **System Health Status** - Real-time health monitoring with color-coded indicators (Healthy/Degraded/Unhealthy)
- **Credit Usage Tracking** - Visual gauge showing credits spent and remaining this month
- **API Response Time** - Monitor API latency in milliseconds

### 📊 Task Analytics
- **Active Tasks Count** - See how many tasks are currently running
- **Completed Tasks Today** - Daily productivity tracking
- **Failed Tasks Count** - Identify issues requiring attention
- **Task Success Rate** - Percentage of successful task completions
- **Average Credits Per Task** - Understand typical task costs
- **Total Tasks This Month** - Monthly activity overview

### 📈 Visual Charts & Graphs
- **Credit Usage Gauge** - Color-coded progress bar (green/yellow/red based on usage)
- **Task Status Distribution** - Animated bar chart showing pending/running/completed/failed tasks
- **Daily Trend Chart** - 7-day sparkline of credit usage
- **Credits by Status Breakdown** - See credits spent on completed vs failed tasks

### 🔔 Smart Alerts
- **Low Credit Warning** - Configurable threshold alert (default: 10%)
- **High Failure Rate Alert** - Notification when task failures exceed threshold (default: 20%)

### 📁 Project Management
- **Total Projects Count** - Overview of all projects
- **Active Projects** - Projects with recent activity
- **Project Selector** - Filter metrics by specific project (optional)

### 📋 Activity Feed
- **Recent Tasks List** - Configurable feed (3-20 tasks) showing:
  - Task title and status
  - Credits consumed
  - Direct links to task URLs
  - Color-coded status indicators

### 🌐 Network Monitoring
- **Real-time Network Activity Indicator** - Pulsing animation during API calls
- **Request Tracking** - Visual feedback for all API operations

### ⚙️ Fully Configurable
- **Toggle Any Feature** - Enable/disable individual metrics via settings
- **Customizable Refresh Interval** - Set update frequency (default: 5 minutes)
- **Alert Thresholds** - Configure warning levels for credits and failures
- **Display Modes** - Compact panel mode or full desktop widget

## Installation

### Quick Install

```bash
# Download and extract
wget https://github.com/jamiefmarra/manus-plasma-widget/archive/refs/heads/main.zip
unzip main.zip
cd manus-plasma-widget-main

# Run installation script
chmod +x install.sh
./install.sh
```

### Manual Installation

```bash
# Copy widget to Plasma widgets directory
mkdir -p ~/.local/share/plasma/plasmoids/
cp -r com.github.jamiefmarra.manusmonitor ~/.local/share/plasma/plasmoids/

# Restart Plasma Shell
kquitapp6 plasmashell && kstart6 plasmashell
```

### Add to Desktop/Panel

1. Right-click on your desktop or panel
2. Select **"Add Widgets..."**
3. Search for **"Manus Monitor"**
4. Drag it to your desktop or panel

## Configuration

### 1. API Key Setup

1. Right-click the widget → **Configure Manus Monitor**
2. Go to **General** tab
3. Enter your Manus API key
4. Set refresh interval (default: 300 seconds)

### 2. Display Options

Navigate to **Display Options** tab to toggle features:

#### Core Metrics
- ☑ Show Health Status
- ☑ Show Credits Spent This Month
- ☑ Show Credits Remaining

#### Task Statistics
- ☑ Show Active Tasks Count
- ☑ Show Completed Tasks Today
- ☑ Show Failed Tasks Count
- ☑ Show Task Success Rate
- ☑ Show Average Credits Per Task
- ☑ Show Total Tasks This Month

#### Activity Feed
- ☑ Show Recent Tasks Feed
- 🔢 Number of Recent Tasks (3-20)

#### Project Metrics
- ☑ Show Total Projects Count
- ☑ Show Active Projects Count
- ☐ Show Project Selector/Filter

#### Charts & Visualizations
- ☑ Show Credit Usage Gauge
- ☑ Show Task Status Chart
- ☑ Show Daily Trend Chart
- ☑ Show Network Activity Indicator

#### Advanced Metrics
- ☐ Show Credits Breakdown by Task Status
- ☐ Show API Response Time

### 3. Alerts Configuration

Navigate to **Alerts** tab:

- **Low Credit Alert**
  - Enable/disable warning
  - Set threshold percentage (1-50%)

- **High Failure Rate Alert**
  - Enable/disable warning
  - Set threshold percentage (5-100%)

## API Integration

The widget uses the official Manus API endpoints:

- `GET /v1/tasks` - Retrieve task data with filtering
- `GET /v1/projects` - Retrieve project information

### Data Processing

- **Real-time Updates** - Fetches data at configurable intervals
- **Smart Caching** - Efficient API usage with local data processing
- **Error Handling** - Graceful degradation with error messages

### Calculated Metrics

Since the Manus API doesn't provide a dedicated usage endpoint, the widget calculates:

- **Credits Spent** - Sum of `credit_usage` from all tasks this month
- **Health Status** - Derived from task failure rates:
  - Healthy: <5% failure rate
  - Degraded: 5-20% failure rate
  - Unhealthy: >20% failure rate
- **Daily Trends** - Aggregated from task timestamps and credit usage

## Display Modes

### Desktop Widget Mode
Full-featured display with all enabled metrics, charts, and activity feed.

### Panel Mode (Compact)
- Small icon with health status indicator
- Network activity pulse animation
- Click to expand full view

## Troubleshooting

### Widget Not Showing Data

1. **Check API Key**: Ensure your Manus API key is correctly entered
2. **Verify Network**: Check internet connection
3. **Review Logs**: Run `journalctl -f` and look for errors
4. **Restart Plasma**: `kquitapp6 plasmashell && kstart6 plasmashell`

### API Errors

- **401 Unauthorized**: Invalid API key - check configuration
- **429 Rate Limit**: Too many requests - increase refresh interval
- **500 Server Error**: Manus API issue - wait and retry

### Performance Issues

- Increase refresh interval to reduce API calls
- Disable unused features in Display Options
- Use compact mode when not actively monitoring

## Uninstallation

```bash
# Run uninstall script
cd manus-plasma-widget-main
chmod +x uninstall.sh
./uninstall.sh

# Or manually remove
rm -rf ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor
```

## Development

### File Structure

```
com.github.jamiefmarra.manusmonitor/
├── metadata.json                    # Widget metadata
├── contents/
│   ├── config/
│   │   ├── main.xml                # Configuration schema
│   │   └── config.qml              # Configuration tabs
│   └── ui/
│       ├── main.qml                # Main widget UI
│       ├── configGeneral.qml       # General settings
│       ├── configDisplay.qml       # Display options
│       └── configAlerts.qml        # Alert settings
```

### Building from Source

```bash
git clone https://github.com/jamiefmarra/manus-plasma-widget.git
cd manus-plasma-widget
./install.sh
```

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Requirements

- **KDE Plasma**: 6.0 or higher
- **Qt**: 6.0 or higher
- **Operating System**: Linux (Ubuntu, Fedora, Arch, etc.)
- **Manus API Key**: Required for data access

## Screenshots

### Desktop Mode
Full widget showing all metrics, charts, and activity feed.

### Panel Mode
Compact icon with health indicator and network activity pulse.

### Configuration
Three-tab configuration interface for customizing all features.

## Roadmap

- [ ] Historical data charts (30-day trends)
- [ ] Export data to CSV
- [ ] Custom color themes
- [ ] Multiple API key support
- [ ] Task filtering by project
- [ ] Desktop notifications integration
- [ ] System tray integration

## License

MIT License - See LICENSE file for details

## Support

- **Issues**: https://github.com/jamiefmarra/manus-plasma-widget/issues
- **Manus API Docs**: https://open.manus.im/docs
- **KDE Plasma Docs**: https://develop.kde.org/docs/plasma/

## Changelog

### Version 2.0.0 (2026-01-25)
- ✨ Added comprehensive task analytics
- ✨ Implemented visual charts and graphs
- ✨ Added network activity monitoring
- ✨ Created fully configurable display options
- ✨ Added smart alerts system
- ✨ Implemented recent tasks activity feed
- ✨ Added project metrics
- ✨ Enhanced compact mode with status indicators
- 🎨 Improved visual design with color-coded elements
- 🐛 Fixed API integration issues
- 📚 Comprehensive documentation

### Version 1.0.0 (2026-01-24)
- 🎉 Initial release
- Basic health monitoring
- Credit usage tracking
- Simple configuration

## Credits

Created by Jamie Marra
Built for the Manus AI platform

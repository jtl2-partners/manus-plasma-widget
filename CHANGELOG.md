# Changelog

All notable changes to the Manus Monitor KDE Plasma Widget will be documented in this file.

## [2.0.0] - 2026-01-25

### ✨ Added

#### Task Analytics
- Active tasks count with real-time updates
- Completed tasks today counter
- Failed tasks tracking
- Task success rate percentage calculation
- Average credits per task metric
- Total tasks this month overview

#### Visual Charts & Graphs
- Credit usage gauge with color-coded progress bar (green/yellow/red)
- Task status distribution bar chart (pending/running/completed/failed)
- Daily credit usage trend chart (7-day sparkline)
- Credits breakdown by task status
- Animated transitions for all charts

#### Network Monitoring
- Real-time network activity indicator with pulse animation
- API response time tracking in milliseconds
- Visual feedback during API calls
- Request tracking for all operations

#### Activity Feed
- Recent tasks list (configurable 3-20 tasks)
- Task titles with status indicators
- Credits consumed per task
- Direct links to task URLs
- Color-coded status badges

#### Project Management
- Total projects count
- Active projects tracking
- Project selector/filter option (configurable)

#### Smart Alerts
- Low credit warning with configurable threshold (1-50%)
- High failure rate alert with configurable threshold (5-100%)
- Desktop notifications for alerts

#### Configuration System
- Comprehensive three-tab configuration interface:
  - **General**: API key and refresh interval
  - **Display Options**: Toggle any feature on/off
  - **Alerts**: Configure warning thresholds
- Individual toggles for all 20+ features
- Configurable recent tasks limit
- Customizable refresh interval

#### Display Enhancements
- Compact panel mode with health status indicator
- Network activity pulse in compact mode
- Enhanced full desktop widget mode
- Scrollable content area for all metrics
- Improved visual hierarchy and spacing

### 🎨 Improved

- Enhanced color-coded health status (Healthy/Degraded/Unhealthy)
- Better visual design with consistent spacing
- Improved error handling and user feedback
- More intuitive configuration interface
- Better responsive layout for different widget sizes

### 🔧 Technical

- Real API integration with Manus `/v1/tasks` endpoint
- Real API integration with Manus `/v1/projects` endpoint
- Intelligent data processing and aggregation
- Efficient caching and update mechanisms
- Proper error handling for network issues
- Support for QML 6.0 and Plasma 6.0

### 📚 Documentation

- Comprehensive README with all features documented
- Detailed configuration guide
- Troubleshooting section
- API integration documentation
- Installation and uninstallation guides

### 🐛 Fixed

- API authentication issues
- Data refresh timing problems
- Layout issues in compact mode
- Configuration persistence
- Error message display

## [1.0.0] - 2026-01-24

### 🎉 Initial Release

#### Core Features
- Basic health status monitoring
- Credits spent this month tracking
- Credits remaining display
- Simple configuration interface
- API key management
- Configurable refresh interval

#### Display Modes
- Desktop widget mode
- Panel compact mode
- Basic visual indicators

#### Configuration
- API key input
- Refresh interval setting
- Basic display toggles

---

## Version Comparison

| Feature | v1.0.0 | v2.0.0 |
|---------|--------|--------|
| Health Status | ✅ | ✅ Enhanced |
| Credits Tracking | ✅ | ✅ Enhanced |
| Task Analytics | ❌ | ✅ |
| Visual Charts | ❌ | ✅ |
| Network Monitoring | ❌ | ✅ |
| Activity Feed | ❌ | ✅ |
| Project Metrics | ❌ | ✅ |
| Smart Alerts | ❌ | ✅ |
| Configurable Features | 3 | 20+ |
| API Endpoints | 0 | 2 |
| Configuration Tabs | 1 | 3 |

---

## Upgrade Guide

### From v1.0.0 to v2.0.0

1. **Backup Configuration**
   ```bash
   cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.config/plasma-org.kde.plasma.desktop-appletsrc.backup
   ```

2. **Uninstall Old Version**
   ```bash
   rm -rf ~/.local/share/plasma/plasmoids/com.github.jamiefmarra.manusmonitor
   ```

3. **Install New Version**
   ```bash
   ./install.sh
   ```

4. **Reconfigure Widget**
   - Your API key should be preserved
   - Review new Display Options tab
   - Configure new Alerts tab if desired

5. **Restart Plasma**
   ```bash
   kquitapp6 plasmashell && kstart6 plasmashell
   ```

### Configuration Migration

All v1.0.0 settings are preserved:
- ✅ API Key
- ✅ Refresh Interval
- ✅ Basic display toggles

New settings default to:
- All task analytics: **Enabled**
- All charts: **Enabled**
- Network activity: **Enabled**
- Recent tasks: **Enabled** (limit: 10)
- Low credit alert: **Enabled** (threshold: 10%)
- High failure alert: **Enabled** (threshold: 20%)

---

## Future Roadmap

### v2.1.0 (Planned)
- Historical data storage (30-day trends)
- Export data to CSV
- Custom color themes
- Multiple API key support

### v2.2.0 (Planned)
- Task filtering by project
- Advanced notifications
- System tray integration
- Widget presets (minimal/standard/full)

### v3.0.0 (Planned)
- Real-time task streaming
- Interactive charts with drill-down
- Cost prediction and budgeting
- Team collaboration features

---

## Breaking Changes

### v2.0.0
- **Minimum Requirements**: KDE Plasma 6.0+ (was 5.27+)
- **API Integration**: Now requires valid API key for all features
- **Configuration**: New three-tab layout (migration automatic)

---

## Known Issues

### v2.0.0
- Canvas-based charts may not render on some older graphics drivers
  - **Workaround**: Disable "Show Daily Trend Chart" in Display Options
- Very large task counts (>1000) may cause slight UI lag
  - **Workaround**: Increase refresh interval to 10+ minutes

---

## Contributors

- **Jamie Marra** - Initial work and v2.0.0 enhancements

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

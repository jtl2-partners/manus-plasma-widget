# Manus Monitor v2.0 - Feature Showcase

## Overview

The Manus Monitor v2.0 is a fully-featured KDE Plasma desktop widget that provides comprehensive monitoring and analytics for your Manus AI usage. With over 20 configurable features, real-time data visualization, and intelligent alerts, you have complete visibility into your Manus operations.

---

## 🎯 Core Monitoring Features

### System Health Status

The widget continuously monitors your Manus system health by analyzing task success rates and provides a clear, color-coded indicator.

**Health Levels:**
- **Healthy** (Green) - Task failure rate below 5%
- **Degraded** (Yellow) - Task failure rate between 5-20%
- **Unhealthy** (Red) - Task failure rate above 20%

**Visual Elements:**
- Large health icon with status color
- Text status label
- Real-time updates every refresh cycle

**Configuration:**
- Toggle: `Show Health Status`
- Location: Display Options → Core Metrics

---

### Credit Usage Tracking

Monitor your credit consumption with a beautiful visual gauge that shows both spent and remaining credits.

**Features:**
- Animated progress bar with color transitions
- Percentage-based color coding (green → yellow → red)
- Precise credit counts for spent and remaining
- Automatic calculation from task data

**Visual Elements:**
- Horizontal gauge bar with smooth animations
- Dual labels showing spent and remaining credits
- Color changes based on usage percentage:
  - Green: <50% used
  - Yellow: 50-80% used
  - Red: >80% used

**Configuration:**
- Toggle: `Show Credit Usage Gauge`
- Toggle: `Show Credits Spent This Month`
- Toggle: `Show Credits Remaining`
- Location: Display Options → Core Metrics

---

### API Response Time

Track the performance of Manus API calls with millisecond precision.

**Features:**
- Real-time latency measurement
- Displayed in milliseconds
- Updates with each API request

**Configuration:**
- Toggle: `Show API Response Time`
- Location: Display Options → Advanced Metrics

---

## 📊 Task Analytics Dashboard

### Active Tasks Counter

See exactly how many tasks are currently running in your Manus account.

**Visual Design:**
- Large numeric display
- Highlighted in theme accent color
- Updates in real-time

**Configuration:**
- Toggle: `Show Active Tasks Count`
- Location: Display Options → Task Statistics

---

### Completed Tasks Today

Track your daily productivity with a counter that shows tasks completed since midnight.

**Features:**
- Resets automatically at midnight
- Color-coded in green (positive)
- Motivational productivity metric

**Configuration:**
- Toggle: `Show Completed Tasks Today`
- Location: Display Options → Task Statistics

---

### Failed Tasks Tracking

Identify issues quickly by monitoring failed task counts.

**Features:**
- Prominent red color coding
- Monthly total of failed tasks
- Triggers high failure rate alerts

**Configuration:**
- Toggle: `Show Failed Tasks Count`
- Location: Display Options → Task Statistics

---

### Task Success Rate

Understand your overall task reliability with a percentage-based success metric.

**Calculation:**
```
Success Rate = (Completed Tasks / (Completed + Failed)) × 100
```

**Visual Design:**
- Large percentage display
- Color-coded based on rate:
  - Green: >80% success
  - Yellow: ≤80% success
- Decimal precision to 1 place

**Configuration:**
- Toggle: `Show Task Success Rate`
- Location: Display Options → Task Statistics

---

### Average Credits Per Task

Understand your typical task costs with this calculated average.

**Calculation:**
```
Avg Credits = Total Credits / (Completed + Failed Tasks)
```

**Use Cases:**
- Budget planning
- Cost optimization
- Identifying expensive workflows

**Configuration:**
- Toggle: `Show Average Credits Per Task`
- Location: Display Options → Task Statistics

---

### Total Tasks This Month

Get a high-level view of your monthly activity volume.

**Features:**
- Counts all tasks created this month
- Includes pending, running, completed, and failed
- Resets automatically on the 1st of each month

**Configuration:**
- Toggle: `Show Total Tasks This Month`
- Location: Display Options → Task Statistics

---

## 📈 Visual Charts & Graphs

### Task Status Distribution Chart

A beautiful animated bar chart showing the breakdown of your tasks by status.

**Status Categories:**
- **Running** (Blue) - Currently executing tasks
- **Completed** (Green) - Successfully finished tasks
- **Failed** (Red) - Tasks that encountered errors
- **Pending** (Gray) - Queued tasks waiting to start

**Visual Features:**
- Horizontal bar chart with smooth animations
- Proportional bar widths based on task counts
- Numeric labels showing exact counts
- Color-coded for instant recognition

**Configuration:**
- Toggle: `Show Task Status Chart`
- Location: Display Options → Charts & Visualizations

---

### Daily Credit Usage Trend

A 7-day sparkline chart showing your credit consumption patterns over the past week.

**Features:**
- Canvas-based bar chart
- Automatic scaling to fit data range
- Shows last 7 days of activity
- Updates with each refresh

**Use Cases:**
- Identify usage spikes
- Spot trends and patterns
- Plan credit purchases

**Configuration:**
- Toggle: `Show Daily Trend Chart`
- Location: Display Options → Charts & Visualizations

---

### Credits Breakdown by Status

Understand where your credits are going with a detailed breakdown by task status.

**Categories:**
- **Completed Tasks** - Credits spent on successful tasks
- **Failed Tasks** - Credits wasted on failed tasks
- **Running Tasks** - Credits currently being consumed

**Visual Design:**
- Grid layout with color-coded labels
- Precise credit counts
- Easy comparison between categories

**Configuration:**
- Toggle: `Show Credits Breakdown by Task Status`
- Location: Display Options → Advanced Metrics

---

## 🌐 Network Activity Monitoring

### Real-Time Network Indicator

A pulsing animation that shows when the widget is actively communicating with the Manus API.

**Features:**
- Animated pulse effect during API calls
- Network icon with color changes
- Visible in both full and compact modes
- Smooth fade in/out transitions

**Visual States:**
- **Active** (Blue, pulsing) - API request in progress
- **Idle** (Gray, static) - No active requests

**Configuration:**
- Toggle: `Show Network Activity Indicator`
- Location: Display Options → Advanced Metrics

---

## 📋 Recent Tasks Activity Feed

### Task Feed List

A scrollable list showing your most recent tasks with full details and quick actions.

**Information Displayed:**
- Task title
- Status (color-coded indicator)
- Credits consumed
- Direct link to task URL

**Visual Design:**
- Card-based layout
- Color-coded status bars (left edge)
- Clickable browser icon for task URLs
- Smooth scrolling

**Status Colors:**
- **Green** - Completed
- **Red** - Failed
- **Blue** - Running
- **Gray** - Pending

**Configuration:**
- Toggle: `Show Recent Tasks Feed`
- Slider: `Number of Recent Tasks` (3-20)
- Location: Display Options → Activity Feed

---

## 📁 Project Management

### Project Metrics

Track your project portfolio with total and active project counts.

**Metrics:**
- **Total Projects** - All projects in your account
- **Active Projects** - Projects with recent activity

**Visual Design:**
- Side-by-side layout
- Large numeric displays
- Active projects highlighted in accent color

**Configuration:**
- Toggle: `Show Total Projects Count`
- Toggle: `Show Active Projects Count`
- Location: Display Options → Project Metrics

---

### Project Selector (Optional)

Filter all widget metrics by a specific project.

**Status:** Configurable option for future enhancement

**Configuration:**
- Toggle: `Show Project Selector/Filter`
- Location: Display Options → Project Metrics

---

## 🔔 Smart Alerts System

### Low Credit Warning

Receive notifications when your remaining credits fall below a configurable threshold.

**Configuration Options:**
- Enable/disable alert
- Set threshold percentage (1-50%)
- Default: 10%

**Alert Trigger:**
```
(Remaining Credits / Total Credits) × 100 < Threshold
```

**Notification:**
- Desktop notification (when supported)
- Console log entry
- Visual indicator in widget

**Configuration:**
- Checkbox: `Enable Low Credit Warning`
- Slider: `Alert Threshold (%)`
- Location: Alerts → Credit Alerts

---

### High Failure Rate Alert

Get notified when your task failure rate exceeds acceptable levels.

**Configuration Options:**
- Enable/disable alert
- Set threshold percentage (5-100%)
- Default: 20%

**Alert Trigger:**
```
(Failed Tasks / Total Finished Tasks) × 100 > Threshold
```

**Use Cases:**
- Identify API issues
- Detect workflow problems
- Monitor system reliability

**Configuration:**
- Checkbox: `Enable High Failure Rate Alert`
- Slider: `Alert Threshold (%)`
- Location: Alerts → Task Failure Alerts

---

## ⚙️ Configuration System

### Three-Tab Interface

The widget features a comprehensive configuration system organized into three logical tabs.

#### Tab 1: General Settings

**API Configuration:**
- API Key input field (password-protected)
- Refresh interval slider (60-3600 seconds)
- Default: 300 seconds (5 minutes)

**Features:**
- Secure API key storage
- Configurable update frequency
- Balance between freshness and API usage

#### Tab 2: Display Options

**Organized Sections:**
1. **Core Metrics** - Health, credits, response time
2. **Task Statistics** - All task-related counters
3. **Activity Feed** - Recent tasks configuration
4. **Project Metrics** - Project tracking options
5. **Charts & Visualizations** - All visual elements
6. **Advanced Metrics** - Optional detailed data

**Features:**
- Individual toggles for each feature
- Instant preview of changes
- Persistent settings across sessions

#### Tab 3: Alerts

**Alert Configuration:**
- Low credit warning settings
- High failure rate alert settings
- Threshold sliders with percentage display
- Enable/disable toggles

**Features:**
- Visual threshold indicators
- Helpful descriptions
- Recommended default values

---

## 🎨 Display Modes

### Desktop Widget Mode

The full-featured display mode designed for desktop placement.

**Characteristics:**
- Scrollable content area
- All enabled features visible
- Optimal size: 30×40 grid units
- Responsive layout

**Best For:**
- Dedicated monitoring space
- Dashboard setups
- Detailed analytics

### Panel Mode (Compact)

A minimal icon representation for panel integration.

**Features:**
- Small icon with health indicator
- Network activity pulse (top-right)
- Health status dot (bottom-right)
- Click to expand full view

**Characteristics:**
- Minimal space usage
- Quick status at a glance
- Hover effects
- Smooth expansion

**Best For:**
- System panel integration
- Space-constrained setups
- Quick monitoring

---

## 🔄 Data Processing & Updates

### Refresh Mechanism

**Automatic Updates:**
- Timer-based refresh at configured interval
- Manual refresh via button
- Automatic retry on errors

**Data Sources:**
- `/v1/tasks` - Task data with filtering
- `/v1/projects` - Project information

**Processing:**
- Real-time calculation of all metrics
- Efficient data aggregation
- Smart caching to reduce API calls

### API Integration

**Request Flow:**
1. Timer triggers or manual refresh
2. Network indicator activates
3. Parallel API requests (tasks + projects)
4. Response parsing and validation
5. Data processing and metric calculation
6. UI updates with animations
7. Network indicator deactivates

**Error Handling:**
- Graceful degradation on errors
- Clear error messages
- Automatic retry logic
- No data loss on failures

---

## 📱 Responsive Design

### Adaptive Layouts

The widget automatically adjusts its layout based on available space.

**Size Categories:**
- **Compact** - Panel mode (icon only)
- **Small** - Minimal metrics (20×15 units)
- **Medium** - Standard view (25×18 units)
- **Large** - Full features (30×40 units)

**Responsive Elements:**
- Grid layouts adjust column count
- Charts scale proportionally
- Text sizes adapt to space
- Scrolling activates when needed

---

## 🎯 Use Cases

### Daily Monitoring

**Setup:**
- Enable all core metrics
- Show recent tasks feed (limit: 5)
- Enable low credit alert
- Refresh interval: 5 minutes

**Benefits:**
- Quick health checks
- Track daily progress
- Catch issues early

### Cost Management

**Setup:**
- Enable credit usage gauge
- Show average credits per task
- Show credits by status breakdown
- Enable low credit alert (threshold: 20%)

**Benefits:**
- Budget tracking
- Cost optimization
- Purchase planning

### Performance Analysis

**Setup:**
- Enable all task statistics
- Show task status chart
- Show daily trend chart
- Show API response time

**Benefits:**
- Identify bottlenecks
- Optimize workflows
- Monitor reliability

### Project Tracking

**Setup:**
- Enable project metrics
- Show recent tasks feed (limit: 10)
- Filter by project (when available)
- Refresh interval: 3 minutes

**Benefits:**
- Project-specific insights
- Team coordination
- Progress tracking

---

## 🚀 Performance Optimization

### Efficient API Usage

**Strategies:**
- Configurable refresh intervals
- Smart request batching
- Response caching
- Parallel request execution

**Recommendations:**
- Use 5-10 minute intervals for normal monitoring
- Increase to 15+ minutes for background monitoring
- Decrease to 1-3 minutes for active development

### UI Performance

**Optimizations:**
- Smooth animations with GPU acceleration
- Lazy loading of charts
- Efficient QML rendering
- Minimal repaints

---

## 📊 Metrics Summary

| Category | Metrics Available | Configurable |
|----------|------------------|--------------|
| Core Metrics | 3 | ✅ |
| Task Statistics | 6 | ✅ |
| Charts | 3 | ✅ |
| Activity Feed | 1 | ✅ (limit) |
| Project Metrics | 2 | ✅ |
| Network | 2 | ✅ |
| Alerts | 2 | ✅ (thresholds) |
| **Total** | **19** | **All** |

---

## 🎨 Visual Design Principles

### Color Coding

**Status Colors:**
- **Green** - Positive, healthy, completed
- **Yellow** - Warning, degraded, moderate
- **Red** - Error, unhealthy, failed
- **Blue** - Active, running, highlighted
- **Gray** - Neutral, pending, inactive

### Typography

**Font Weights:**
- **Bold** - Metric values, headings
- **Regular** - Labels, descriptions
- **Light** - Secondary information

**Font Sizes:**
- **2x** - Primary metrics
- **1.5x** - Section headings
- **1x** - Standard text
- **0.8x** - Secondary labels

### Spacing

**Consistent Units:**
- Small spacing: 1 unit
- Medium spacing: 2 units
- Large spacing: 3 units
- Section spacing: 4 units

---

## 🔧 Troubleshooting Features

### Built-in Diagnostics

**Error Display:**
- Inline error messages
- Color-coded severity
- Actionable error text

**Status Indicators:**
- Loading spinner during updates
- Network activity pulse
- Health status changes

**Debug Information:**
- Console logging
- API response times
- Request tracking

---

## 🌟 Unique Selling Points

1. **Fully Configurable** - Toggle any feature on/off
2. **Real-Time Data** - Live updates from Manus API
3. **Beautiful Visualizations** - Charts and graphs with animations
4. **Smart Alerts** - Proactive notifications
5. **Dual Display Modes** - Desktop widget and panel icon
6. **Production-Ready** - No mock data, real API integration
7. **Performance Optimized** - Efficient resource usage
8. **User-Friendly** - Intuitive configuration interface
9. **Comprehensive Analytics** - 19+ metrics available
10. **Open Source** - MIT licensed, community-driven

---

## 📚 Documentation

Complete documentation available:
- **README.md** - Installation and usage guide
- **CHANGELOG.md** - Version history and updates
- **ADDITIONAL_FEATURES.md** - Feature ideas and roadmap
- **FEATURES_SHOWCASE.md** - This document

---

## 🎉 Conclusion

The Manus Monitor v2.0 is the most comprehensive monitoring solution for Manus AI users. With its extensive feature set, beautiful visualizations, and complete configurability, you have everything you need to monitor, analyze, and optimize your Manus usage.

**Get Started:**
```bash
git clone https://github.com/jamiefmarra/manus-plasma-widget.git
cd manus-plasma-widget
./install.sh
```

**Configure:**
1. Add widget to desktop/panel
2. Right-click → Configure
3. Enter your API key
4. Customize display options
5. Set up alerts

**Enjoy:**
- Real-time monitoring
- Beautiful visualizations
- Smart alerts
- Complete control

---

**Version:** 2.0.0  
**Last Updated:** January 25, 2026  
**Author:** Jamie Marra  
**License:** MIT

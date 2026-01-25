import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    width: Kirigami.Units.gridUnit * 30
    height: Kirigami.Units.gridUnit * 40

    // Configuration properties
    property string apiKey: plasmoid.configuration.apiKey
    property int refreshInterval: plasmoid.configuration.refreshInterval * 1000

    // Display configuration
    property bool showHealthStatus: plasmoid.configuration.showHealthStatus
    property bool showCreditsSpent: plasmoid.configuration.showCreditsSpent
    property bool showCreditsRemaining: plasmoid.configuration.showCreditsRemaining
    property bool showActiveTasks: plasmoid.configuration.showActiveTasks
    property bool showCompletedToday: plasmoid.configuration.showCompletedToday
    property bool showFailedTasks: plasmoid.configuration.showFailedTasks
    property bool showTaskSuccessRate: plasmoid.configuration.showTaskSuccessRate
    property bool showAverageCreditsPerTask: plasmoid.configuration.showAverageCreditsPerTask
    property bool showTotalTasksMonth: plasmoid.configuration.showTotalTasksMonth
    property bool showRecentTasks: plasmoid.configuration.showRecentTasks
    property int recentTasksLimit: plasmoid.configuration.recentTasksLimit
    property bool showTotalProjects: plasmoid.configuration.showTotalProjects
    property bool showActiveProjects: plasmoid.configuration.showActiveProjects
    property bool showProjectSelector: plasmoid.configuration.showProjectSelector
    property bool showCreditUsageGauge: plasmoid.configuration.showCreditUsageGauge
    property bool showTaskStatusChart: plasmoid.configuration.showTaskStatusChart
    property bool showDailyTrendChart: plasmoid.configuration.showDailyTrendChart
    property bool showNetworkActivity: plasmoid.configuration.showNetworkActivity
    property bool showCreditsByStatus: plasmoid.configuration.showCreditsByStatus
    property bool showApiResponseTime: plasmoid.configuration.showApiResponseTime

    // Alert configuration
    property bool enableLowCreditAlert: plasmoid.configuration.enableLowCreditAlert
    property int lowCreditThreshold: plasmoid.configuration.lowCreditThreshold
    property bool enableHighFailureAlert: plasmoid.configuration.enableHighFailureAlert
    property int highFailureThreshold: plasmoid.configuration.highFailureThreshold

    // Data properties
    property string healthStatus: "unknown"
    property int creditsSpent: 0
    property int creditsRemaining: 0
    property int totalCredits: 0
    property int activeTasks: 0
    property int completedToday: 0
    property int failedTasks: 0
    property real successRate: 0
    property real avgCreditsPerTask: 0
    property int totalTasksMonth: 0
    property int totalProjects: 0
    property int activeProjects: 0
    property var recentTasksList: []
    property var dailyTrendData: []
    property var taskStatusData: {"pending": 0, "running": 0, "completed": 0, "failed": 0}
    property var creditsByStatusData: {"completed": 0, "failed": 0, "pending": 0, "running": 0}
    property int apiResponseTime: 0
    property bool isLoading: false
    property bool networkActive: false
    property string lastError: ""

    // Network request tracking
    property int pendingRequests: 0

    Plasmoid.icon: "utilities-system-monitor"
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    // Compact representation for panel
    compactRepresentation: Item {
        PlasmaCore.IconItem {
            id: compactIcon
            anchors.fill: parent
            source: plasmoid.icon
            active: compactMouse.containsMouse
            
            Rectangle {
                width: Kirigami.Units.smallSpacing * 2
                height: Kirigami.Units.smallSpacing * 2
                radius: width / 2
                color: getHealthColor()
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 2
                border.width: 1
                border.color: "white"
            }

            Rectangle {
                width: Kirigami.Units.smallSpacing
                height: Kirigami.Units.smallSpacing
                radius: width / 2
                color: Kirigami.Theme.highlightColor
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 2
                visible: root.networkActive
                opacity: 0.8

                SequentialAnimation on opacity {
                    running: root.networkActive
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.3; to: 1.0; duration: 500 }
                    NumberAnimation { from: 1.0; to: 0.3; duration: 500 }
                }
            }
        }
        
        MouseArea {
            id: compactMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.expanded = !root.expanded
        }
    }

    // Full representation
    fullRepresentation: ColumnLayout {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 25
        Layout.minimumHeight: Kirigami.Units.gridUnit * 30
        spacing: Kirigami.Units.smallSpacing

        // Header with network indicator
        RowLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing

            Kirigami.Heading {
                level: 3
                text: "Manus Monitor"
                Layout.fillWidth: true
            }

            // Network activity indicator
            Rectangle {
                id: networkIndicator
                width: Kirigami.Units.iconSizes.small
                height: width
                radius: width / 2
                color: root.networkActive ? Kirigami.Theme.highlightColor : Kirigami.Theme.disabledTextColor
                visible: root.showNetworkActivity
                
                Kirigami.Icon {
                    anchors.centerIn: parent
                    width: parent.width * 0.6
                    height: width
                    source: "network-connect"
                    color: "white"
                }

                SequentialAnimation on opacity {
                    running: root.networkActive
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.3; to: 1.0; duration: 500 }
                    NumberAnimation { from: 1.0; to: 0.3; duration: 500 }
                }
            }

            PlasmaComponents.ToolButton {
                icon.name: "view-refresh"
                onClicked: fetchAllData()
                enabled: !root.isLoading
            }

            PlasmaComponents.ToolButton {
                icon.name: "configure"
                onClicked: plasmoid.internalAction("configure").trigger()
            }
        }

        // Error message
        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Error
            text: root.lastError
            visible: root.lastError !== ""
        }

        // No API key message
        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            text: "Please configure your Manus API key in settings"
            visible: root.apiKey === ""
        }

        // Scrollable content area
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: Kirigami.Units.largeSpacing

                // Health Status Card
                Rectangle {
                    Layout.fillWidth: true
                    height: healthLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showHealthStatus

                    RowLayout {
                        id: healthLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.largeSpacing

                        Kirigami.Icon {
                            source: getHealthIcon()
                            width: Kirigami.Units.iconSizes.large
                            height: width
                            color: getHealthColor()
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: "System Health"
                                font.weight: Font.Bold
                            }

                            PlasmaComponents.Label {
                                text: root.healthStatus.charAt(0).toUpperCase() + root.healthStatus.slice(1)
                                color: getHealthColor()
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                            }
                        }

                        // API Response Time
                        ColumnLayout {
                            spacing: 2
                            visible: root.showApiResponseTime

                            PlasmaComponents.Label {
                                text: "API Response"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                            }

                            PlasmaComponents.Label {
                                text: root.apiResponseTime + " ms"
                                font.weight: Font.Bold
                            }
                        }
                    }
                }

                // Credit Usage Gauge
                Rectangle {
                    Layout.fillWidth: true
                    height: gaugeLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showCreditUsageGauge && (root.showCreditsSpent || root.showCreditsRemaining)

                    ColumnLayout {
                        id: gaugeLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Credit Usage This Month"
                            font.weight: Font.Bold
                        }

                        // Visual gauge
                        Rectangle {
                            Layout.fillWidth: true
                            height: Kirigami.Units.gridUnit * 2
                            color: Kirigami.Theme.alternateBackgroundColor
                            radius: height / 2

                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: root.totalCredits > 0 ? parent.width * (root.creditsSpent / root.totalCredits) : 0
                                color: {
                                    var percentage = root.totalCredits > 0 ? (root.creditsSpent / root.totalCredits) * 100 : 0
                                    if (percentage < 50) return Kirigami.Theme.positiveTextColor
                                    if (percentage < 80) return Kirigami.Theme.neutralTextColor
                                    return Kirigami.Theme.negativeTextColor
                                }
                                radius: parent.radius

                                Behavior on width { NumberAnimation { duration: 300 } }
                            }

                            PlasmaComponents.Label {
                                anchors.centerIn: parent
                                text: formatNumber(root.creditsSpent) + " credits"
                                font.weight: Font.Bold
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            PlasmaComponents.Label {
                                text: "Spent: " + formatNumber(root.creditsSpent)
                                visible: root.showCreditsSpent
                            }

                            Item { Layout.fillWidth: true }

                            PlasmaComponents.Label {
                                text: "Remaining: " + formatNumber(root.creditsRemaining)
                                visible: root.showCreditsRemaining
                            }
                        }
                    }
                }

                // Task Statistics Grid
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: Kirigami.Units.smallSpacing
                    columnSpacing: Kirigami.Units.smallSpacing

                    // Active Tasks
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showActiveTasks

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatNumber(root.activeTasks)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                color: Kirigami.Theme.highlightColor
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Active Tasks"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Completed Today
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showCompletedToday

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatNumber(root.completedToday)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                color: Kirigami.Theme.positiveTextColor
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Completed Today"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Failed Tasks
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showFailedTasks

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatNumber(root.failedTasks)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                color: Kirigami.Theme.negativeTextColor
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Failed Tasks"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Success Rate
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showTaskSuccessRate

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatDecimal(root.successRate, 1) + "%"
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                color: root.successRate > 80 ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.neutralTextColor
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Success Rate"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Average Credits
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showAverageCreditsPerTask

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatDecimal(root.avgCreditsPerTask, 0)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Avg Credits/Task"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    // Total Tasks Month
                    Rectangle {
                        Layout.fillWidth: true
                        height: Kirigami.Units.gridUnit * 4
                        color: Kirigami.Theme.backgroundColor
                        border.color: Kirigami.Theme.separatorColor
                        border.width: 1
                        radius: Kirigami.Units.smallSpacing
                        visible: root.showTotalTasksMonth

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: formatNumber(root.totalTasksMonth)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 2
                                font.weight: Font.Bold
                                Layout.alignment: Qt.AlignHCenter
                            }

                            PlasmaComponents.Label {
                                text: "Tasks This Month"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }

                // Task Status Chart
                Rectangle {
                    Layout.fillWidth: true
                    height: statusChartLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showTaskStatusChart

                    ColumnLayout {
                        id: statusChartLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Task Status Distribution"
                            font.weight: Font.Bold
                        }

                        // Simple bar chart
                        GridLayout {
                            Layout.fillWidth: true
                            columns: 2
                            rowSpacing: Kirigami.Units.smallSpacing
                            columnSpacing: Kirigami.Units.smallSpacing

                            Repeater {
                                model: [
                                    {status: "Running", count: root.taskStatusData.running, color: Kirigami.Theme.highlightColor},
                                    {status: "Completed", count: root.taskStatusData.completed, color: Kirigami.Theme.positiveTextColor},
                                    {status: "Failed", count: root.taskStatusData.failed, color: Kirigami.Theme.negativeTextColor},
                                    {status: "Pending", count: root.taskStatusData.pending, color: Kirigami.Theme.neutralTextColor}
                                ]

                                delegate: RowLayout {
                                    Layout.fillWidth: true
                                    spacing: Kirigami.Units.smallSpacing

                                    PlasmaComponents.Label {
                                        text: modelData.status
                                        Layout.preferredWidth: Kirigami.Units.gridUnit * 5
                                        font.pointSize: Kirigami.Theme.smallFont.pointSize
                                    }

                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: Kirigami.Units.gridUnit
                                        color: Kirigami.Theme.alternateBackgroundColor
                                        radius: height / 2

                                        Rectangle {
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            width: root.totalTasksMonth > 0 ? parent.width * (modelData.count / root.totalTasksMonth) : 0
                                            color: modelData.color
                                            radius: parent.radius

                                            Behavior on width { NumberAnimation { duration: 300 } }
                                        }
                                    }

                                    PlasmaComponents.Label {
                                        text: modelData.count
                                        font.weight: Font.Bold
                                        Layout.preferredWidth: Kirigami.Units.gridUnit * 2
                                    }
                                }
                            }
                        }
                    }
                }

                // Credits by Status
                Rectangle {
                    Layout.fillWidth: true
                    height: creditsByStatusLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showCreditsByStatus

                    ColumnLayout {
                        id: creditsByStatusLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Credits by Task Status"
                            font.weight: Font.Bold
                        }

                        GridLayout {
                            Layout.fillWidth: true
                            columns: 2
                            rowSpacing: Kirigami.Units.smallSpacing
                            columnSpacing: Kirigami.Units.smallSpacing

                            PlasmaComponents.Label {
                                text: "Completed:"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                            }
                            PlasmaComponents.Label {
                                text: formatNumber(root.creditsByStatusData.completed) + " credits"
                                font.weight: Font.Bold
                                color: Kirigami.Theme.positiveTextColor
                            }

                            PlasmaComponents.Label {
                                text: "Failed:"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                            }
                            PlasmaComponents.Label {
                                text: formatNumber(root.creditsByStatusData.failed) + " credits"
                                font.weight: Font.Bold
                                color: Kirigami.Theme.negativeTextColor
                            }

                            PlasmaComponents.Label {
                                text: "Running:"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                            }
                            PlasmaComponents.Label {
                                text: formatNumber(root.creditsByStatusData.running) + " credits"
                                font.weight: Font.Bold
                            }
                        }
                    }
                }

                // Project Metrics
                Rectangle {
                    Layout.fillWidth: true
                    height: projectMetricsLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showTotalProjects || root.showActiveProjects

                    RowLayout {
                        id: projectMetricsLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.largeSpacing

                        ColumnLayout {
                            Layout.fillWidth: true
                            visible: root.showTotalProjects

                            PlasmaComponents.Label {
                                text: formatNumber(root.totalProjects)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                                font.weight: Font.Bold
                            }
                            PlasmaComponents.Label {
                                text: "Total Projects"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            visible: root.showActiveProjects

                            PlasmaComponents.Label {
                                text: formatNumber(root.activeProjects)
                                font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                                font.weight: Font.Bold
                                color: Kirigami.Theme.highlightColor
                            }
                            PlasmaComponents.Label {
                                text: "Active Projects"
                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                opacity: 0.7
                            }
                        }
                    }
                }

                // Recent Tasks Feed
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: recentTasksLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showRecentTasks

                    ColumnLayout {
                        id: recentTasksLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Recent Tasks"
                            font.weight: Font.Bold
                        }

                        Repeater {
                            model: root.recentTasksList

                            delegate: Rectangle {
                                Layout.fillWidth: true
                                height: taskItemLayout.implicitHeight + Kirigami.Units.smallSpacing * 2
                                color: Kirigami.Theme.alternateBackgroundColor
                                radius: Kirigami.Units.smallSpacing

                                RowLayout {
                                    id: taskItemLayout
                                    anchors.fill: parent
                                    anchors.margins: Kirigami.Units.smallSpacing
                                    spacing: Kirigami.Units.smallSpacing

                                    Rectangle {
                                        width: Kirigami.Units.smallSpacing
                                        height: parent.height
                                        radius: width / 2
                                        color: {
                                            switch(modelData.status) {
                                                case "completed": return Kirigami.Theme.positiveTextColor
                                                case "failed": return Kirigami.Theme.negativeTextColor
                                                case "running": return Kirigami.Theme.highlightColor
                                                default: return Kirigami.Theme.neutralTextColor
                                            }
                                        }
                                    }

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        PlasmaComponents.Label {
                                            text: modelData.title
                                            font.weight: Font.Bold
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }

                                        RowLayout {
                                            spacing: Kirigami.Units.largeSpacing

                                            PlasmaComponents.Label {
                                                text: modelData.status
                                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                                opacity: 0.7
                                            }

                                            PlasmaComponents.Label {
                                                text: modelData.credits + " credits"
                                                font.pointSize: Kirigami.Theme.smallFont.pointSize
                                                opacity: 0.7
                                            }
                                        }
                                    }

                                    PlasmaComponents.ToolButton {
                                        icon.name: "internet-web-browser"
                                        visible: modelData.url !== ""
                                        onClicked: Qt.openUrlExternally(modelData.url)
                                    }
                                }
                            }
                        }

                        PlasmaComponents.Label {
                            text: "No recent tasks"
                            opacity: 0.5
                            visible: root.recentTasksList.length === 0
                        }
                    }
                }

                // Daily Trend Chart
                Rectangle {
                    Layout.fillWidth: true
                    height: dailyTrendLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
                    color: Kirigami.Theme.backgroundColor
                    border.color: Kirigami.Theme.separatorColor
                    border.width: 1
                    radius: Kirigami.Units.smallSpacing
                    visible: root.showDailyTrendChart && root.dailyTrendData.length > 0

                    ColumnLayout {
                        id: dailyTrendLayout
                        anchors.fill: parent
                        anchors.margins: Kirigami.Units.largeSpacing
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Daily Credit Usage (Last 7 Days)"
                            font.weight: Font.Bold
                        }

                        // Simple sparkline
                        Canvas {
                            id: trendCanvas
                            Layout.fillWidth: true
                            Layout.preferredHeight: Kirigami.Units.gridUnit * 6

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.clearRect(0, 0, width, height)

                                if (root.dailyTrendData.length === 0) return

                                // Find max value
                                var maxCredits = 0
                                for (var i = 0; i < root.dailyTrendData.length; i++) {
                                    if (root.dailyTrendData[i].credits > maxCredits) {
                                        maxCredits = root.dailyTrendData[i].credits
                                    }
                                }

                                if (maxCredits === 0) return

                                // Draw bars
                                var barWidth = width / root.dailyTrendData.length
                                var padding = barWidth * 0.2

                                for (var j = 0; j < root.dailyTrendData.length; j++) {
                                    var barHeight = (root.dailyTrendData[j].credits / maxCredits) * height
                                    var x = j * barWidth + padding
                                    var y = height - barHeight

                                    ctx.fillStyle = Kirigami.Theme.highlightColor.toString()
                                    ctx.fillRect(x, y, barWidth - padding * 2, barHeight)
                                }
                            }

                            Connections {
                                target: root
                                function onDailyTrendDataChanged() {
                                    trendCanvas.requestPaint()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Refresh timer
    Timer {
        id: refreshTimer
        interval: root.refreshInterval
        running: root.apiKey !== ""
        repeat: true
        onTriggered: fetchAllData()
    }

    // Initial load
    Component.onCompleted: {
        if (root.apiKey !== "") {
            fetchAllData()
        }
    }

    function fetchAllData() {
        if (root.apiKey === "") return
        
        root.isLoading = true
        root.lastError = ""
        root.pendingRequests = 0
        
        // Fetch tasks data
        fetchTasks()
        
        // Fetch projects data
        if (root.showTotalProjects || root.showActiveProjects) {
            fetchProjects()
        }
    }

    function fetchTasks() {
        root.pendingRequests++
        root.networkActive = true
        
        var startTime = Date.now()
        var xhr = new XMLHttpRequest()
        
        // Get tasks from current month
        var now = new Date()
        var monthStart = new Date(now.getFullYear(), now.getMonth(), 1)
        var monthStartTimestamp = Math.floor(monthStart.getTime() / 1000)
        
        xhr.open("GET", "https://api.manus.ai/v1/tasks?limit=1000&createdAfter=" + monthStartTimestamp, true)
        xhr.setRequestHeader("API_KEY", root.apiKey)
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                root.pendingRequests--
                if (root.pendingRequests === 0) {
                    root.networkActive = false
                    root.isLoading = false
                }
                
                root.apiResponseTime = Date.now() - startTime
                
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        processTasks(response.data || [])
                    } catch (e) {
                        root.lastError = "Failed to parse tasks: " + e.message
                        console.error("Parse error:", e)
                    }
                } else {
                    root.lastError = "API Error: " + xhr.status
                    console.error("API error:", xhr.status, xhr.responseText)
                }
            }
        }
        
        xhr.send()
    }

    function fetchProjects() {
        root.pendingRequests++
        root.networkActive = true
        
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "https://api.manus.ai/v1/projects?limit=1000", true)
        xhr.setRequestHeader("API_KEY", root.apiKey)
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                root.pendingRequests--
                if (root.pendingRequests === 0) {
                    root.networkActive = false
                    root.isLoading = false
                }
                
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        processProjects(response.data || [])
                    } catch (e) {
                        console.error("Parse error:", e)
                    }
                } else {
                    console.error("Projects API error:", xhr.status)
                }
            }
        }
        
        xhr.send()
    }

    function processTasks(tasks) {
        // Reset counters
        root.activeTasks = 0
        root.completedToday = 0
        root.failedTasks = 0
        root.creditsSpent = 0
        root.totalTasksMonth = tasks.length
        
        var completedCount = 0
        var totalCreditsForAvg = 0
        var taskCountForAvg = 0
        
        var statusCounts = {"pending": 0, "running": 0, "completed": 0, "failed": 0}
        var creditsByStatus = {"completed": 0, "failed": 0, "pending": 0, "running": 0}
        
        var recentTasks = []
        var dailyData = {}
        
        var now = Date.now() / 1000
        var todayStart = new Date()
        todayStart.setHours(0, 0, 0, 0)
        var todayTimestamp = todayStart.getTime() / 1000
        
        // Process each task
        for (var i = 0; i < tasks.length; i++) {
            var task = tasks[i]
            var status = task.status || "unknown"
            var credits = task.credit_usage || 0
            var createdAt = task.created_at || 0
            
            // Count by status
            if (status === "running") {
                root.activeTasks++
            } else if (status === "completed") {
                completedCount++
                if (createdAt >= todayTimestamp) {
                    root.completedToday++
                }
            } else if (status === "failed") {
                root.failedTasks++
            }
            
            // Track status counts
            if (statusCounts.hasOwnProperty(status)) {
                statusCounts[status]++
            }
            
            // Track credits by status
            if (creditsByStatus.hasOwnProperty(status)) {
                creditsByStatus[status] += credits
            }
            
            // Sum credits
            root.creditsSpent += credits
            
            // Calculate average (only for completed/failed tasks)
            if (status === "completed" || status === "failed") {
                totalCreditsForAvg += credits
                taskCountForAvg++
            }
            
            // Daily trend data
            var dateKey = new Date(createdAt * 1000).toLocaleDateString()
            if (!dailyData[dateKey]) {
                dailyData[dateKey] = {date: dateKey, credits: 0, tasks: 0}
            }
            dailyData[dateKey].credits += credits
            dailyData[dateKey].tasks++
            
            // Recent tasks
            if (recentTasks.length < root.recentTasksLimit) {
                recentTasks.push({
                    title: task.metadata?.task_title || "Untitled Task",
                    url: task.metadata?.task_url || "",
                    status: status,
                    credits: credits,
                    created_at: createdAt
                })
            }
        }
        
        // Calculate success rate
        var totalFinished = completedCount + root.failedTasks
        root.successRate = totalFinished > 0 ? (completedCount / totalFinished) * 100 : 0
        
        // Calculate average credits
        root.avgCreditsPerTask = taskCountForAvg > 0 ? totalCreditsForAvg / taskCountForAvg : 0
        
        // Update status data
        root.taskStatusData = statusCounts
        root.creditsByStatusData = creditsByStatus
        
        // Update recent tasks
        root.recentTasksList = recentTasks
        
        // Convert daily data to array and sort
        var dailyArray = []
        for (var key in dailyData) {
            dailyArray.push(dailyData[key])
        }
        dailyArray.sort(function(a, b) {
            return new Date(a.date) - new Date(b.date)
        })
        root.dailyTrendData = dailyArray.slice(-7) // Last 7 days
        
        // Determine health status
        updateHealthStatus()
        
        // Check alerts
        checkAlerts()
    }

    function processProjects(projects) {
        root.totalProjects = projects.length
        
        // Count active projects (projects with tasks in last 7 days)
        // Note: This would require cross-referencing with tasks, simplified here
        root.activeProjects = projects.length
    }

    function updateHealthStatus() {
        // Derive health from task failure rate
        var totalFinished = root.totalTasksMonth - root.activeTasks
        if (totalFinished === 0) {
            root.healthStatus = "unknown"
            return
        }
        
        var failureRate = (root.failedTasks / totalFinished) * 100
        
        if (failureRate < 5) {
            root.healthStatus = "healthy"
        } else if (failureRate < 20) {
            root.healthStatus = "degraded"
        } else {
            root.healthStatus = "unhealthy"
        }
    }

    function checkAlerts() {
        // Low credit alert
        if (root.enableLowCreditAlert && root.totalCredits > 0) {
            var creditPercentage = (root.creditsRemaining / root.totalCredits) * 100
            if (creditPercentage < root.lowCreditThreshold) {
                showNotification("Low Credits Warning", 
                    "Only " + Math.round(creditPercentage) + "% of credits remaining!")
            }
        }
        
        // High failure alert
        if (root.enableHighFailureAlert) {
            var totalFinished = root.totalTasksMonth - root.activeTasks
            if (totalFinished > 0) {
                var failureRate = (root.failedTasks / totalFinished) * 100
                if (failureRate > root.highFailureThreshold) {
                    showNotification("High Failure Rate", 
                        "Task failure rate is " + Math.round(failureRate) + "%!")
                }
            }
        }
    }

    function showNotification(title, message) {
        // KDE notification (would need proper notification API in production)
        console.log("NOTIFICATION:", title, "-", message)
    }

    function getHealthColor() {
        switch(root.healthStatus) {
            case "healthy": return Kirigami.Theme.positiveTextColor
            case "degraded": return Kirigami.Theme.neutralTextColor
            case "unhealthy": return Kirigami.Theme.negativeTextColor
            default: return Kirigami.Theme.textColor
        }
    }

    function getHealthIcon() {
        switch(root.healthStatus) {
            case "healthy": return "checkmark"
            case "degraded": return "warning"
            case "unhealthy": return "error"
            default: return "help-about"
        }
    }

    function formatNumber(num) {
        return Math.round(num).toString()
    }

    function formatDecimal(num, decimals) {
        return num.toFixed(decimals || 1)
    }
}

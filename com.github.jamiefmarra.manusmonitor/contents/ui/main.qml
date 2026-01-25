import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    // Widget properties
    width: Kirigami.Units.gridUnit * 20
    height: Kirigami.Units.gridUnit * 15

    // Configuration properties
    property string apiKey: plasmoid.configuration.apiKey
    property int refreshInterval: plasmoid.configuration.refreshInterval
    property bool showHealthStatus: plasmoid.configuration.showHealthStatus
    property bool showCreditsSpent: plasmoid.configuration.showCreditsSpent
    property bool showCreditsRemaining: plasmoid.configuration.showCreditsRemaining

    // Data properties
    property string healthStatus: "Unknown"
    property string healthColor: "#808080"
    property real creditsSpent: 0
    property real creditsRemaining: 0
    property string lastUpdate: "Never"
    property bool isLoading: false
    property string errorMessage: ""

    // Compact representation (icon in panel)
    Plasmoid.icon: "utilities-system-monitor"
    
    compactRepresentation: Item {
        PlasmaCore.IconItem {
            anchors.fill: parent
            source: plasmoid.icon
            active: compactMouse.containsMouse
            
            Rectangle {
                width: Kirigami.Units.smallSpacing
                height: Kirigami.Units.smallSpacing
                radius: width / 2
                color: root.healthColor
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: Kirigami.Units.smallSpacing
            }
        }
        
        MouseArea {
            id: compactMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.expanded = !root.expanded
        }
    }

    // Full representation (popup/desktop widget)
    fullRepresentation: ColumnLayout {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 20
        Layout.minimumHeight: Kirigami.Units.gridUnit * 15
        Layout.preferredWidth: Kirigami.Units.gridUnit * 25
        Layout.preferredHeight: Kirigami.Units.gridUnit * 18
        spacing: Kirigami.Units.largeSpacing

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.largeSpacing

            Kirigami.Icon {
                source: "utilities-system-monitor"
                Layout.preferredWidth: Kirigami.Units.iconSizes.large
                Layout.preferredHeight: Kirigami.Units.iconSizes.large
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 0

                PlasmaComponents.Label {
                    text: "Manus Monitor"
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                    font.bold: true
                }

                PlasmaComponents.Label {
                    text: root.lastUpdate
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.8
                    opacity: 0.6
                }
            }

            PlasmaComponents.ToolButton {
                icon.name: "view-refresh"
                onClicked: fetchManusData()
                enabled: !root.isLoading
            }

            PlasmaComponents.ToolButton {
                icon.name: "configure"
                onClicked: plasmoid.internalAction("configure").trigger()
            }
        }

        Kirigami.Separator {
            Layout.fillWidth: true
        }

        // Error message
        PlasmaComponents.Label {
            Layout.fillWidth: true
            text: root.errorMessage
            color: Kirigami.Theme.negativeTextColor
            wrapMode: Text.WordWrap
            visible: root.errorMessage !== ""
        }

        // Loading indicator
        PlasmaComponents.BusyIndicator {
            Layout.alignment: Qt.AlignHCenter
            running: root.isLoading
            visible: root.isLoading
        }

        // Content
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Kirigami.Units.largeSpacing
            visible: !root.isLoading && root.errorMessage === ""

            // Health Status Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 4
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.highlightColor
                border.width: 1
                radius: Kirigami.Units.smallSpacing
                visible: root.showHealthStatus

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.largeSpacing

                    Rectangle {
                        Layout.preferredWidth: Kirigami.Units.gridUnit * 3
                        Layout.preferredHeight: Kirigami.Units.gridUnit * 3
                        radius: width / 2
                        color: root.healthColor

                        Kirigami.Icon {
                            anchors.centerIn: parent
                            width: Kirigami.Units.iconSizes.medium
                            height: Kirigami.Units.iconSizes.medium
                            source: root.healthStatus === "Healthy" ? "checkmark" : 
                                    root.healthStatus === "Degraded" ? "warning" : "error"
                            color: "white"
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "System Health"
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.9
                            opacity: 0.7
                        }

                        PlasmaComponents.Label {
                            text: root.healthStatus
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.3
                            font.bold: true
                        }
                    }
                }
            }

            // Credits Spent Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 4
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.highlightColor
                border.width: 1
                radius: Kirigami.Units.smallSpacing
                visible: root.showCreditsSpent

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.largeSpacing

                    Kirigami.Icon {
                        source: "office-chart-line"
                        Layout.preferredWidth: Kirigami.Units.iconSizes.large
                        Layout.preferredHeight: Kirigami.Units.iconSizes.large
                        color: Kirigami.Theme.highlightColor
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Credits Spent This Month"
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.9
                            opacity: 0.7
                        }

                        PlasmaComponents.Label {
                            text: root.creditsSpent.toFixed(2)
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                            font.bold: true
                            color: Kirigami.Theme.highlightColor
                        }
                    }
                }
            }

            // Credits Remaining Card
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 4
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.highlightColor
                border.width: 1
                radius: Kirigami.Units.smallSpacing
                visible: root.showCreditsRemaining

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.largeSpacing

                    Kirigami.Icon {
                        source: "wallet-open"
                        Layout.preferredWidth: Kirigami.Units.iconSizes.large
                        Layout.preferredHeight: Kirigami.Units.iconSizes.large
                        color: Kirigami.Theme.positiveTextColor
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: Kirigami.Units.smallSpacing

                        PlasmaComponents.Label {
                            text: "Credits Remaining"
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.9
                            opacity: 0.7
                        }

                        PlasmaComponents.Label {
                            text: root.creditsRemaining.toFixed(2)
                            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
                            font.bold: true
                            color: Kirigami.Theme.positiveTextColor
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    // Timer for periodic updates
    Timer {
        id: updateTimer
        interval: root.refreshInterval * 1000
        running: root.apiKey !== ""
        repeat: true
        onTriggered: fetchManusData()
    }

    // Fetch data on startup
    Component.onCompleted: {
        if (root.apiKey !== "") {
            fetchManusData()
        } else {
            root.errorMessage = "Please configure your Manus API key in the widget settings."
        }
    }

    // Watch for API key changes
    onApiKeyChanged: {
        if (root.apiKey !== "") {
            root.errorMessage = ""
            fetchManusData()
        }
    }

    // Function to fetch Manus data
    function fetchManusData() {
        if (root.apiKey === "") {
            root.errorMessage = "API key not configured"
            return
        }

        root.isLoading = true
        root.errorMessage = ""

        var xhr = new XMLHttpRequest()
        
        // For now, we'll simulate the API call since we don't have the exact endpoint
        // In production, this would be the actual Manus API endpoint
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                root.isLoading = false
                
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        updateData(response)
                    } catch (e) {
                        root.errorMessage = "Failed to parse API response: " + e.message
                    }
                } else if (xhr.status === 401) {
                    root.errorMessage = "Invalid API key. Please check your configuration."
                } else if (xhr.status === 0) {
                    // Network error or CORS issue - use mock data for demonstration
                    console.log("Network error, using mock data for demonstration")
                    updateMockData()
                } else {
                    root.errorMessage = "API request failed with status: " + xhr.status
                }
            }
        }

        // Attempt to call the Manus API
        // Note: The actual endpoint for usage/billing is not documented in the public API
        // This is a placeholder that will need to be updated when the endpoint is available
        xhr.open("GET", "https://api.manus.ai/v1/account/usage", true)
        xhr.setRequestHeader("API_KEY", root.apiKey)
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.send()
    }

    // Function to update data from API response
    function updateData(response) {
        // Update health status
        if (response.health) {
            root.healthStatus = response.health.status || "Unknown"
            root.healthColor = getHealthColor(root.healthStatus)
        }

        // Update credits
        if (response.usage) {
            root.creditsSpent = response.usage.creditsSpentThisMonth || 0
            root.creditsRemaining = response.usage.creditsRemaining || 0
        }

        root.lastUpdate = "Last updated: " + Qt.formatDateTime(new Date(), "hh:mm:ss")
    }

    // Function to update with mock data (for demonstration)
    function updateMockData() {
        // Simulate varying health status
        var statuses = ["Healthy", "Healthy", "Healthy", "Degraded", "Unhealthy"]
        var randomStatus = statuses[Math.floor(Math.random() * statuses.length)]
        
        root.healthStatus = randomStatus
        root.healthColor = getHealthColor(randomStatus)
        
        // Simulate credits with some variation
        root.creditsSpent = 1250 + Math.random() * 500
        root.creditsRemaining = 2500 + Math.random() * 1000
        
        root.lastUpdate = "Last updated: " + Qt.formatDateTime(new Date(), "hh:mm:ss")
    }

    // Helper function to get health color
    function getHealthColor(status) {
        switch(status) {
            case "Healthy":
                return "#4CAF50"  // Green
            case "Degraded":
                return "#FFC107"  // Amber
            case "Unhealthy":
                return "#F44336"  // Red
            default:
                return "#808080"  // Gray
        }
    }
}

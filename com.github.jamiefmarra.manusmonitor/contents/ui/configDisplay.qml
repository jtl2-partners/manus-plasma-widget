import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: displayPage

    // Core Metrics
    property alias cfg_showHealthStatus: showHealthCheckBox.checked
    property alias cfg_showCreditsSpent: showSpentCheckBox.checked
    property alias cfg_showCreditsRemaining: showRemainingCheckBox.checked

    // Task Statistics
    property alias cfg_showActiveTasks: showActiveTasksCheckBox.checked
    property alias cfg_showCompletedToday: showCompletedTodayCheckBox.checked
    property alias cfg_showFailedTasks: showFailedTasksCheckBox.checked
    property alias cfg_showTaskSuccessRate: showSuccessRateCheckBox.checked
    property alias cfg_showAverageCreditsPerTask: showAvgCreditsCheckBox.checked
    property alias cfg_showTotalTasksMonth: showTotalTasksCheckBox.checked

    // Activity Feed
    property alias cfg_showRecentTasks: showRecentTasksCheckBox.checked
    property alias cfg_recentTasksLimit: recentTasksLimitSpinBox.value

    // Project Metrics
    property alias cfg_showTotalProjects: showTotalProjectsCheckBox.checked
    property alias cfg_showActiveProjects: showActiveProjectsCheckBox.checked
    property alias cfg_showProjectSelector: showProjectSelectorCheckBox.checked

    // Charts and Visualizations
    property alias cfg_showCreditUsageGauge: showCreditGaugeCheckBox.checked
    property alias cfg_showTaskStatusChart: showTaskChartCheckBox.checked
    property alias cfg_showDailyTrendChart: showDailyTrendCheckBox.checked
    property alias cfg_showNetworkActivity: showNetworkActivityCheckBox.checked

    // Advanced Metrics
    property alias cfg_showCreditsByStatus: showCreditsByStatusCheckBox.checked
    property alias cfg_showApiResponseTime: showApiResponseTimeCheckBox.checked

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Core Metrics")
    }

    QQC2.CheckBox {
        id: showHealthCheckBox
        text: i18n("Show Health Status")
        Kirigami.FormData.label: i18n("System Health:")
    }

    QQC2.CheckBox {
        id: showSpentCheckBox
        text: i18n("Show Credits Spent This Month")
    }

    QQC2.CheckBox {
        id: showRemainingCheckBox
        text: i18n("Show Credits Remaining")
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Task Statistics")
    }

    QQC2.CheckBox {
        id: showActiveTasksCheckBox
        text: i18n("Show Active Tasks Count")
        Kirigami.FormData.label: i18n("Task Metrics:")
    }

    QQC2.CheckBox {
        id: showCompletedTodayCheckBox
        text: i18n("Show Completed Tasks Today")
    }

    QQC2.CheckBox {
        id: showFailedTasksCheckBox
        text: i18n("Show Failed Tasks Count")
    }

    QQC2.CheckBox {
        id: showSuccessRateCheckBox
        text: i18n("Show Task Success Rate")
    }

    QQC2.CheckBox {
        id: showAvgCreditsCheckBox
        text: i18n("Show Average Credits Per Task")
    }

    QQC2.CheckBox {
        id: showTotalTasksCheckBox
        text: i18n("Show Total Tasks This Month")
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Activity Feed")
    }

    QQC2.CheckBox {
        id: showRecentTasksCheckBox
        text: i18n("Show Recent Tasks Feed")
        Kirigami.FormData.label: i18n("Recent Activity:")
    }

    QQC2.SpinBox {
        id: recentTasksLimitSpinBox
        Kirigami.FormData.label: i18n("Number of Recent Tasks:")
        from: 3
        to: 20
        value: 5
        enabled: showRecentTasksCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Project Metrics")
    }

    QQC2.CheckBox {
        id: showTotalProjectsCheckBox
        text: i18n("Show Total Projects Count")
        Kirigami.FormData.label: i18n("Projects:")
    }

    QQC2.CheckBox {
        id: showActiveProjectsCheckBox
        text: i18n("Show Active Projects Count")
    }

    QQC2.CheckBox {
        id: showProjectSelectorCheckBox
        text: i18n("Show Project Selector/Filter")
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Charts & Visualizations")
    }

    QQC2.CheckBox {
        id: showCreditGaugeCheckBox
        text: i18n("Show Credit Usage Gauge")
        Kirigami.FormData.label: i18n("Visual Elements:")
    }

    QQC2.CheckBox {
        id: showTaskChartCheckBox
        text: i18n("Show Task Status Chart")
    }

    QQC2.CheckBox {
        id: showDailyTrendCheckBox
        text: i18n("Show Daily Trend Chart")
    }

    QQC2.CheckBox {
        id: showNetworkActivityCheckBox
        text: i18n("Show Network Activity Indicator")
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Advanced Metrics")
    }

    QQC2.CheckBox {
        id: showCreditsByStatusCheckBox
        text: i18n("Show Credits Breakdown by Task Status")
        Kirigami.FormData.label: i18n("Advanced:")
    }

    QQC2.CheckBox {
        id: showApiResponseTimeCheckBox
        text: i18n("Show API Response Time")
    }
}

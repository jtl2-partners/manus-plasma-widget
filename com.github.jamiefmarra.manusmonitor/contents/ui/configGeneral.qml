import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: generalPage

    property alias cfg_apiKey: apiKeyField.text
    property alias cfg_refreshInterval: refreshIntervalSpinBox.value
    property alias cfg_showHealthStatus: showHealthCheckBox.checked
    property alias cfg_showCreditsSpent: showSpentCheckBox.checked
    property alias cfg_showCreditsRemaining: showRemainingCheckBox.checked

    QQC2.TextField {
        id: apiKeyField
        Kirigami.FormData.label: i18n("Manus API Key:")
        placeholderText: i18n("Enter your Manus API key")
        echoMode: TextInput.Password
    }

    QQC2.SpinBox {
        id: refreshIntervalSpinBox
        Kirigami.FormData.label: i18n("Refresh Interval (seconds):")
        from: 60
        to: 3600
        stepSize: 60
        value: 300
    }

    Item {
        Kirigami.FormData.isSection: true
    }

    QQC2.CheckBox {
        id: showHealthCheckBox
        text: i18n("Show Health Status")
        checked: true
    }

    QQC2.CheckBox {
        id: showSpentCheckBox
        text: i18n("Show Credits Spent This Month")
        checked: true
    }

    QQC2.CheckBox {
        id: showRemainingCheckBox
        text: i18n("Show Credits Remaining")
        checked: true
    }
}

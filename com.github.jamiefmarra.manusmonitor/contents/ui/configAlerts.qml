import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: alertsPage

    property alias cfg_enableLowCreditAlert: lowCreditAlertCheckBox.checked
    property alias cfg_lowCreditThreshold: lowCreditThresholdSpinBox.value
    property alias cfg_enableHighFailureAlert: highFailureAlertCheckBox.checked
    property alias cfg_highFailureThreshold: highFailureThresholdSpinBox.value

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Credit Alerts")
    }

    QQC2.CheckBox {
        id: lowCreditAlertCheckBox
        text: i18n("Enable Low Credit Warning")
        Kirigami.FormData.label: i18n("Low Credits:")
    }

    QQC2.SpinBox {
        id: lowCreditThresholdSpinBox
        Kirigami.FormData.label: i18n("Alert Threshold (%):")
        from: 1
        to: 50
        value: 10
        enabled: lowCreditAlertCheckBox.checked
        
        textFromValue: function(value) {
            return value + "%"
        }
        
        valueFromText: function(text) {
            return parseInt(text)
        }
    }

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        type: Kirigami.MessageType.Information
        text: i18n("You will be notified when your remaining credits fall below this percentage.")
        visible: lowCreditAlertCheckBox.checked
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Task Failure Alerts")
    }

    QQC2.CheckBox {
        id: highFailureAlertCheckBox
        text: i18n("Enable High Failure Rate Alert")
        Kirigami.FormData.label: i18n("Task Failures:")
    }

    QQC2.SpinBox {
        id: highFailureThresholdSpinBox
        Kirigami.FormData.label: i18n("Alert Threshold (%):")
        from: 5
        to: 100
        value: 20
        enabled: highFailureAlertCheckBox.checked
        
        textFromValue: function(value) {
            return value + "%"
        }
        
        valueFromText: function(text) {
            return parseInt(text)
        }
    }

    Kirigami.InlineMessage {
        Layout.fillWidth: true
        type: Kirigami.MessageType.Information
        text: i18n("You will be notified when task failure rate exceeds this percentage.")
        visible: highFailureAlertCheckBox.checked
    }
}

import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Display Options")
        icon: "view-visible"
        source: "configDisplay.qml"
    }
    ConfigCategory {
        name: i18n("Alerts")
        icon: "notifications"
        source: "configAlerts.qml"
    }
}

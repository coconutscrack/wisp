// ClockWidget.qml
import QtQuick
import Quickshell

Text {
  text: Qt.formatDateTime(Time.date, "hh:mm")
}

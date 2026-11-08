import Quickshell
import QtQuick
import qs.services
import qs.config

Column {
  spacing: 6
  Text {
    text: {
      switch (Wifi.displayStatus) {
        case Wifi.Status.HardwareDisabled:
        case Wifi.Status.NoDevice:
          return "󰤫"
        case Wifi.Status.Off:
          return "󰤭"
        case Wifi.Status.NotConnected:
          return "󰤯"
        case Wifi.Status.Connected:
          if (Wifi.connectedNetwork.signalStrength < 1/4) {
            return "󰤟"
          } else if (Wifi.connectedNetwork.signalStrength < 2/4) {
            return "󰤢"
          } else if (Wifi.connectedNetwork.signalStrength < 3/4) {
            return "󰤥"
          } else {
            return "󰤨"
          }
      }
    }
    color: Colors.text
    font.family: Fonts.icon
    font.pixelSize: 36
    font.bold: false
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
  Text {
    text: {
      switch (Wifi.displayStatus) {
        case Wifi.Status.HardwareDisabled:
          return "Hardware disabled"
        case Wifi.Status.NoDevice:
          return "No device found"
        case Wifi.Status.Off:
          return "Off"
        case Wifi.Status.NotConnected:
          return "Not connected"
        case Wifi.Status.Connected:
          return Wifi.connectedNetwork.name
      }
    }
    color: Colors.text
    font.family: Fonts.text
    font.pixelSize: 12
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
}

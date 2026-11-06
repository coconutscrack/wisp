import Quickshell
import QtQuick
import qs.services
import qs.config

// remove later and move focus to carousel
import Quickshell.Wayland

Card {
  quickAction: function() {
    Wifi.toggle()
  }
  border.width: 2
  border.color: Wifi.enabled ? Colors.border : "transparent"

  Column {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    spacing: 6
    Text {
      text: {
        if (Wifi.device == null || !Wifi.hardwareEnabled) {
          return "󰤫"
        } else if (Wifi.enabled) {
          if (Wifi.connectedNetwork != null) {
            if (Wifi.connectedNetwork.signalStrength < 1/4) {
              return "󰤟"
            } else if (Wifi.connectedNetwork.signalStrength < 2/4) {
              return "󰤢"
            } else if (Wifi.connectedNetwork.signalStrength < 3/4) {
              return "󰤥"
            } else {
              return "󰤨"
            }
          } else {
            return "󰤯"
          }
        } else if (!Wifi.enabled) {
          return "󰤭"
        }
      }
      font.family: Fonts.icon
      font.pixelSize: 36
      font.bold: false
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }
    Text {
      text: "Wi-Fi"
      font.family: Fonts.text
      font.pixelSize: 24
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }
    Text {
      text: {
        if (Wifi.device == null) return "No device found"
        if (!Wifi.hardwareEnabled) {
          return "Hardware disabled"
        } else if (Wifi.enabled) {
          if (Wifi.connectedNetwork != null) {
            return Wifi.connectedNetwork.name
          }
          return "Not connected"
        } else if (!Wifi.enabled) {
          return "Off"
        }
      }
      font.family: Fonts.text
      font.pixelSize: 12
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }
  }
}

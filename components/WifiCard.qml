import Quickshell
import QtQuick
import qs.services
import qs.config

Card {
  Text {
    text: "Wi-Fi"
    font.family: Fonts.text
    font.pixelSize: 20
    font.bold: false
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
  }
}

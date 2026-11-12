import Quickshell
import QtQuick
import qs.services
import qs.config

Column {
  spacing: 6
  Text {
    text: "󰐥"
    color: Colors.text
    font.family: Fonts.icon
    font.pixelSize: 36
    font.bold: false
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
  Text {
    text: "Power"
    font.family: Fonts.text
    font.pixelSize: 24
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Colors.text
  }
  Text {
    text: {
      let s = "up"
      if (Time.uptimeHours) s += ` ${Time.uptimeHours}h`
      s += ` ${Time.uptimeMinutes}m`
      s += ` ${Time.uptimeSeconds}s`
      return s
    }
    color: Colors.text
    font.family: Fonts.text
    font.pixelSize: 12
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
}

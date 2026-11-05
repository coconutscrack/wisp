import QtQuick
import QtQuick.Controls
import qs.config
import qs.services

Button {
  id: root

  property real low: 1 / 4
  property real mid: 2 / 4
  property real high: 3 / 4
  required property int fontSize

  contentItem: Text {
    text: {
      if (Backlight.brightness < low ) {
        return "󰃞"
      } else if (Backlight.brightness < mid) {
        return "󰃝"
      } else if (Backlight.brightness < high) {
        return "󰃟"
      } else {
        return "󰃠"
      }
    }
    color: Colors.text

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font.family: Fonts.icon
    font.pixelSize: root.fontSize
  }

  background: Rectangle {
    color: "transparent"
  }
}

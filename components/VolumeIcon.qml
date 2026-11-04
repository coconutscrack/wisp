import QtQuick
import QtQuick.Controls
import Quickshell
import qs.config
import qs.services

Button {
  id: root

  property real low: 1 / 3
  property real mid: 2 / 3
  property real high: 3 / 3
  required property int fontSize

  contentItem: Text {
    text: {
      if (Audio.muted) {
        return ""
      } else if (Audio.volume === 0) {
        return ""
      } else if (Audio.volume < root.low) {
        return ""
      } else if (Audio.volume < root.mid) {
        return ""
      } else {
        return ""
      }
    }

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: Fonts.icon
    color: Colors.text
    font.pixelSize: root.fontSize
  }

  onClicked: Audio.toggleMuted()

  background: Rectangle {
    radius: height / 2
    color: hovered ? Colors.textMuted : "#00000000"
  }
}

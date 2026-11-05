import QtQuick
import QtQuick.Controls
import qs.config
import qs.services

Button {
  id: root

  property real low: 1 / 3
  property real mid: 2 / 3
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
    font.pixelSize: root.fontSize

    color: Audio.muted ? Colors.critical : Colors.text
    Behavior on color {
      ColorAnimation {
        easing.type: Config.anims.colorCurve
        duration: Config.anims.colorDuration
      }
    }
  }

  onClicked: Audio.toggleMuted()

  background: Rectangle {
    color: "transparent"
  }

  HoverHandler {
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    cursorShape: Qt.PointingHandCursor
  }
}

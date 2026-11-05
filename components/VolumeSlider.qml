import QtQuick
import QtQuick.Controls
import qs.config
import qs.services

Slider {
  id: control

  from: 0
  value: Audio.volume
  to: 1

  orientation: Qt.Vertical

  property real fillProgress: visualPosition
  onMoved: {
    Audio.setVolume(value)
  }

  HoverHandler {
    id: hoverHandler
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    cursorShape: control.pressed ? Qt.ClosedHandCursor : Qt.PointingHandCursor
  }

  Behavior on fillProgress {
    enabled: !control.pressed
    NumberAnimation { 
      easing.type: Config.anims.sliderCurve
      duration: Config.anims.sliderDuration
    }
  }

  background: Rectangle {
    x: control.leftPadding
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: Config.volumeControls.width
    implicitHeight: Config.volumeControls.height
    width: implicitWidth
    height: control.availableHeight
    radius: width / 2
    color: Colors.textMuted

    Rectangle {
      property real padding: parent.width / 4
      y: padding + control.fillProgress * (control.availableHeight - (padding * 2) - width)
      width: parent.width - padding * 2
      anchors.horizontalCenter: parent.horizontalCenter
      height: control.availableHeight - padding - y
      color: Colors.text
      radius: width / 2

    }
  }

  handle: Rectangle {
    x: control.leftPadding + control.availableWidth / 2 - width / 2
    y: control.topPadding + control.visualPosition * (control.availableHeight - height)
    implicitWidth: 10
    implicitHeight: 10
    radius: 5
    color: "transparent"
  }
}

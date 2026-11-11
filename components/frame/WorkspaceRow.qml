import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
  id: root

  property real cellOffset: FocusedWorkspace.wsId - 1

  clip: true

  Behavior on opacity {
    NumberAnimation { 
      easing.type: Config.anims.fadeCurve
      duration: Config.anims.fadeDuration
    }
  }

  Row {
    anchors.verticalCenter: parent.verticalCenter
    x: (root.width / 2) - (Config.workspaces.slotWidth / 2) - (root.cellOffset * Config.workspaces.slotWidth)

    Repeater {
      model: Config.workspaces.count
      Item {
        id: wsIdContainer

        required property var modelData
        property real diffToFocused: Math.abs((root.cellOffset) - modelData)
        property real alpha: { Math.max(Colors.alpha * (1 - (diffToFocused / (Config.workspaces.visibleSlots / 2))), 0) }

        implicitWidth: Config.workspaces.slotWidth
        implicitHeight: Config.workspaces.slotHeight

        Text {
          anchors.centerIn: parent
          text: wsIdContainer.modelData + 1
          color: Qt.alpha(Colors.text, wsIdContainer.alpha)
          font.pixelSize: Config.workspaces.fontSize
          font.family: Fonts.text
          scale: { Math.pow(Config.workspaces.stepKeepScale, wsIdContainer.diffToFocused) }
        }
      }
    }
  }
}

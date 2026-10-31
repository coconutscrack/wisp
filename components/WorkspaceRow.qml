import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
  id: root
  // anchors { top: parent.top; bottom: parent.bottom }
  // anchors.horizontalCenter: parent.horizontalCenter
  property real cellOffset: FocusedWorkspace.wsId - 1
  // width: frame.bumpPlateauWidth
  // opacity: bottomPanel.open ? 1 : 0
  clip: true

  Behavior on cellOffset {
    NumberAnimation { 
      easing.type: Config.anims.workspaceIndicatorCurve
      duration: Config.anims.workspaceIndicatorDuration
    }
  }

  // Behavior on opacity {
  //   NumberAnimation { 
  //     easing.type: Config.anims.fadeCurve
  //     duration: Config.anims.fadeDuration
  //   }
  // }

  Row {
    anchors.verticalCenter: parent.verticalCenter
    x: (root.width / 2) - (Config.workspaces.slotWidth / 2) - (root.cellOffset * Config.workspaces.slotWidth)

    Repeater {
      model: Config.workspaces.count
      Item {
        required property var modelData
        id: wsIdContainer
        implicitWidth: Config.workspaces.slotWidth
        implicitHeight: Config.workspaces.slotHeight
        Text {
          anchors.centerIn: parent
          text: wsIdContainer.modelData + 1
          color: Colors.text
        }
      }
    }
  }
}

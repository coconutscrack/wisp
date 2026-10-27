import QtQuick
import Quickshell
import Quickshell.Hyprland
import QtQuick.Layouts


PanelWindow {
  anchors { left: true }
  exclusiveZone: 0
  aboveWindows: true
  margins {
    left: 10
  }
  FlexboxLayout {
    anchors.fill: parent
    direction: FlexboxLayout.Column

    Repeater {
      model: Hyprland.workspaces
      Rectangle {
        required property var modelData

        width: 100
        height: 3
        border.color: "black"
        border.width: 5
        radius: 10

        Text {
          text: modelData.id
        }
      }
    }
  }
}

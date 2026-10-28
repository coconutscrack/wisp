import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts


Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "qs"

      anchors { left: true }
      implicitWidth: shell.width
      implicitHeight: shell.height
      exclusiveZone: 0
      aboveWindows: true
      margins {
        left: shell.width
      }
      color: "transparent"

      Rectangle {
        id: shell
        color: "#FFFFFF"
        opacity: 0.6
        implicitWidth: workspaceContainer.width + 20
        implicitHeight: workspaceContainer.height + 20 
        border.color: "#33000000"
        border.width: 2
        radius: 100
      }

      ColumnLayout {
        id: workspaceContainer
        anchors.centerIn: parent


        Repeater {
          model: Hyprland.workspaces.values.filter(w => !w.name.startsWith("special:"))
          Rectangle {
            required property var modelData

            id: ws
            implicitWidth: 20
            implicitHeight: ma.containsMouse ? tmpHeight + 6 : tmpHeight

            property real tmpHeight
            states: [
              State {
                name: "UNFOCUSED"
                when: !modelData.focused
                PropertyChanges { ws.tmpHeight: 40 }
                PropertyChanges { ws.color: "#40181820" }
              },
              State {
                name: "FOCUSED"
                when: modelData.focused
                PropertyChanges { ws.tmpHeight: 60 }
                PropertyChanges { ws.color: "#d9181820" }
              }
            ]

            MouseArea {
              id: ma
              anchors.fill: parent
              hoverEnabled: true
            }

            color: "black"
            radius: 100
          }
        }
      }
    }
  }
}

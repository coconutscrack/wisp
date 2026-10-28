import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts


Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: root

      required property var modelData
      screen: modelData

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "qs"

      BackgroundEffect.blurRegion: Region { item: root.contentItem }

      anchors { bottom: true }
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
        color: "#F0EFED"
        opacity: 1
        implicitWidth: workspaceContainer.width + 20
        implicitHeight: workspaceContainer.height + 20
        border.color: "#33000000"
        border.width: 2
        radius: 100
      }

      RowLayout {
        id: workspaceContainer
        anchors.centerIn: parent

        Repeater {
          model: 10
          Rectangle {
            required property var modelData
            property int wsId: modelData + 1
            property int isFocused: {
              if (Hyprland.focusedWorkspace == null) return false
              return (Hyprland.focusedWorkspace.id === wsId) ? true : false
            }

            id: ws
            implicitWidth: 30
            implicitHeight: 30

            states: [
              State {
                name: "UNFOCUSED"
                when: !isFocused
                PropertyChanges { ws.color: "transparent" }
              },
              State {
                name: "FOCUSED"
                when: isFocused
                PropertyChanges { ws.color: "#D1CCC2" }
              }
            ]

            MouseArea {
              id: ma
              anchors.fill: parent
              hoverEnabled: true
            }

            Text {
              anchors.centerIn: parent
              color: isFocused ? "#F2F0EB" : "#393934"
              text: wsId
            }

            color: "black"
            radius: 100
          }
        }
      }
    }
  }
}

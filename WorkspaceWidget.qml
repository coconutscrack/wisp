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
        color: "#F2F0EB"
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
          // model: Hyprland.workspaces.values.filter(w => !w.name.startsWith("special:"))
          model: 10
          Rectangle {
            required property var modelData
            property int wsId: modelData + 1
            // property var workspace = Hyprland.workspaces.values[modelData]

            id: ws
            implicitWidth: 30
            implicitHeight: 30

            property real tmpHeight
            states: [
              State {
                name: "UNFOCUSED"
                when: !(wsId === Hyprland.focusedWorkspace.id)
                PropertyChanges { ws.tmpHeight: 40 }
                PropertyChanges { ws.color: "transparent" }
              },
              State {
                name: "FOCUSED"
                when: modelData.focused
                PropertyChanges { ws.tmpHeight: 60 }
                PropertyChanges { ws.color: "#F2F0EB" }
              }
            ]

            MouseArea {
              id: ma
              anchors.fill: parent
              hoverEnabled: true
            }

            Text {
              anchors.centerIn: parent
              color: "#393934"
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

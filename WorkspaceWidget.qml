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

      visible: false
      
      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.namespace: "qs"

      BackgroundEffect.blurRegion: Region { 
        radius: shell.radius
        height: shell.height - shell.border.width * 2
        width: shell.width - shell.border.width * 2
        x: shell.border.width
        y: shell.border.width
      }

      anchors { bottom: true }
      implicitWidth: shell.width
      implicitHeight: shell.height
      exclusiveZone: 0
      aboveWindows: true
      margins {
        bottom: shell.height / 2
      }

      color: "transparent"

      Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
          root.visible = true
          makeInvisible.restart()
        }
      }

      Timer {
        id: makeInvisible

        interval: 2000
        running: true
        repeat: false
        onTriggered: {
          root.visible = false
        }
      }

      Rectangle {
        id: shell

        color: "#F0EFED"
        opacity: 0.8
        implicitWidth: workspaceContainer.width + workspaceContainer.height / 1.5
        implicitHeight: workspaceContainer.height + workspaceContainer.height / 1.5
        border.color: "#FFBEB8AF"
        border.width: 1
        radius: height / 2
      }

      RowLayout {
        id: workspaceContainer
        anchors.centerIn: parent

        Repeater {
          model: 10
          Rectangle {
            required property var modelData
            property int wsId: modelData + 1
            property bool isFocused: {
              if (Hyprland.focusedWorkspace == null) return false
              return Hyprland.focusedWorkspace.id === wsId
            }

            id: ws
            implicitWidth: 35
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
                PropertyChanges { ws.color: "#9C8A84" }
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
            opacity: 0.8
            radius: height / 2
          }
        }
      }
    }
  }
}

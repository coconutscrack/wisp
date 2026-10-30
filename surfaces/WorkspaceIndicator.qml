import qs.components
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Variants {
  model: Quickshell.screens
  PanelWindow {
    required property var modelData
    id: root

    screen: modelData

    WorkspaceBadge { id: badge }

    visible: false

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "wisp-pop-in"

    BackgroundEffect.blurRegion: Region { 
      radius: badge.radius
      height: badge.height - badge.border.width * 2
      width: badge.width - badge.border.width * 2
      x: badge.border.width
      y: badge.border.width
    }

    anchors { bottom: true; left: true }
    implicitWidth: badge.width
    implicitHeight: badge.height
    exclusiveZone: 0
    aboveWindows: true
    margins {
      bottom: badge.height
      left: badge.height
    }

    color: "transparent"
    
    function isMyMonitor(monitorName) {
      return modelData.name == monitorName
    }

    function showWorkspaceIndicator(focusedMonitor) {
      if (!isMyMonitor(focusedMonitor)) {
        root.visible = false
        return
      }
      root.visible = true
      makeInvisible.restart()
    }

    Connections {
      target: Hyprland

      function onFocusedWorkspaceChanged() {
        if (Hyprland.focusedMonitor == null) return
        root.showWorkspaceIndicator(Hyprland.focusedMonitor.name)
      }

      function onRawEvent(event) {
        if (!(event.name === "activespecial")) return

        let data = event.data.split(",")
        if (!isMyMonitor(data[1])) return
        if (!data[0]) {
          badge.specialName = ""
          // showWorkspaceIndicator(data[1])
          return
        }

        badge.specialName = data[0].replace("special:", "")
        showWorkspaceIndicator(data[1])
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
  }
}

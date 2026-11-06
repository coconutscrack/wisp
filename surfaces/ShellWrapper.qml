import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.services

Scope {
  Variants {
    model: Quickshell.screens

    Scope {
      required property var modelData
      readonly property HyprlandMonitor monitor: Hyprland.monitorFor(modelData)
      property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
      property var hasFullscreen: monitor?.activeWorkspace?.hasFullscreen

      Spacer {
        screen: modelData
        direction: "top"
      }

      Spacer {
        screen: modelData
        direction: "bottom"
      }

      Spacer {
        screen: modelData
        direction: "left"
      }

      Spacer {
        screen: modelData
        direction: "right"
      }

      Overlay {
        visible: monitor.name === focusedScreen?.name && OverlayStatus.open
        WlrLayershell.layer: WlrLayer.Overlay
        screen: modelData
        Connections {
          target: FocusedWorkspace
          function onWsIdChanged() {
            OverlayStatus.open = false
          }
        }
      }

      Frame {
        visible: monitor.name === focusedScreen?.name && (!hasFullscreen || hasOpenPanel)
        WlrLayershell.layer: WlrLayer.Overlay
        screen: modelData
      }
    }
  }
}

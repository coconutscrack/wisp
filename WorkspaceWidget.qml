import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
  anchors {
    left: true
    bottom: true
    right: true
  }
  
  implicitHeight: 20

  Text {
    text: hyprland.workspaces
  }
}

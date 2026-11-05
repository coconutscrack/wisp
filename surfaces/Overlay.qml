import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
  id: root

  anchors {
    top: true
    bottom : true
    left: true
    right: true
  }

  mask: Region {
    item: overlay
  }

  WlrLayershell.namespace: "wisp-overlay"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Rectangle {
    id: overlay

    color: Qt.alpha(Colors.background, Colors.overlayAlpha)

    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }
  }
}

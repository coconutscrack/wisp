import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

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
  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "wisp-overlay"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Rectangle {
    id: overlay

    visible: OverlayStatus.open
    color: Qt.alpha(Colors.background, 0.5)

    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }

  }
}

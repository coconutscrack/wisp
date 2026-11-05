import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components
import qs.services

PanelWindow {
  id: root

  // required property FramePanel topPanel
  // required property FramePanel bottomPanel
  // required property FramePanel rightPanel
  //
  anchors {
    top: true
    bottom : true
    left: true
    right: true
  }

  mask: Region {
    item: overlay
    // Region {
    //   item: rightPanel
    //   intersection: Intersection.Subtract
    // }
  }
  // WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "wisp-overlay"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Rectangle {
    id: overlay

    // visible: OverlayStatus.open
    color: Qt.alpha(Colors.background, Colors.overlayAlpha)

    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }
  }
}

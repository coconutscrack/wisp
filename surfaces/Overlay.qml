import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components

PanelWindow {
  id: root

  WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
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

    WifiCard {
      focus: true
      Keys.onSpacePressed: {
        if (WifiCard.hasQuickAction) quickAction()
      }
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}

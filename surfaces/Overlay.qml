import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.components
import qs.services

PanelWindow {
  id: root

  onVisibleChanged: {
    if (!visible) {
      carousel.focusedCard.expanded = false
    }
  }

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

    Keys.onPressed: function(event) {
      switch (event.key) {
        case Qt.Key_H:
          carousel.moveFocusTo(carousel.focusedIdx - 1)
          break
        case Qt.Key_L:
          carousel.moveFocusTo(carousel.focusedIdx + 1)
          break
        case Qt.Key_Space:
          if (carousel.focusedCard.hasQuickAction) carousel.focusedCard.quickAction()
          break
        case Qt.Key_Return:
          carousel.focusedCard.expanded = true
          break
        case Qt.Key_Escape:
          if (carousel.focusedCard.expanded == true) {
            carousel.focusedCard.expanded = false
          } else {
            OverlayStatus.open = false
          }
          break
      }
    }

    Carousel { 
      id: carousel 
      focus: true
    }
  }
}

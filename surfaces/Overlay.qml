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
      id: wifiCard
      focus: true
      Keys.onSpacePressed: {
        if (hasQuickAction) quickAction()
      }
      Keys.onReturnPressed: {
        wifiCard.expanded = true
      }
      Keys.onEscapePressed: {
        wifiCard.expanded = false
      }
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenter: parent.verticalCenter
    }
    // Item {
    //   Loader { 
    //     id: widgetLoader
    //     source: "WifiCard.qml"
    //   }
    //   focus: true
    //   Keys.onSpacePressed: {
    //     if (hasQuickAction) quickAction()
    //   }
    //   Keys.onEnterPressed: {
    //     widgetLoader.source = "WifiExpanded.qml"
    //   }
    //   anchors.horizontalCenter: parent.horizontalCenter
    //   anchors.verticalCenter: parent.verticalCenter
    // }
  }
}

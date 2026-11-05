import QtQuick
import Quickshell
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Wayland
import qs.config
import qs.components
import qs.services

PanelWindow {
  id: root

  property bool hasOpenPanel: topPanel.open || bottomPanel.open || rightPanel.open

  anchors {
    top: true
    bottom : true
    left: true
    right: true
  }

  mask: Region {
    Region {
      item: rightPanel
    }
  }

  WlrLayershell.namespace: "qs"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Shape {
    layer.enabled: true
    layer.effect: MultiEffect {
      autoPaddingEnabled: false
      blurMax: Config.frame.thickness
      shadowColor: Qt.rgba(0, 0, 0, 1)
      shadowEnabled: true
      shadowBlur: 1.0
    }

    anchors.fill: parent

    preferredRendererType: Shape.CurveRenderer
    FrameInnerEdge {
      outerWidth: root.width
      outerHeight: root.height
      topPanel: topPanel
      bottomPanel: bottomPanel
      rightPanel: rightPanel
      
      fillColor: Qt.alpha(Colors.background, Colors.alpha)

      PathRectangle {
        width: root.width
        height: root.height
      }
    }
  }

  FramePanel {
    id: topPanel

    direction: "top"
    openWidth: clock.width
    openHeight: clock.height

    Clock {
      id: clock
      opacity: topPanel.openByOverlay ? 1 : 0
      anchors.verticalCenter: topPanel.verticalCenter
      anchors.horizontalCenter: topPanel.horizontalCenter
    }
  }

  FramePanel {
    id: bottomPanel

    direction: "bottom"
    openHeight: Config.workspaces.slotHeight
    openWidth: Config.workspaces.slotWidth * Config.workspaces.visibleSlots

    Connections {
      target: FocusedWorkspace
      function onWsIdChanged() { 
        bottomPanel.openByChange = true
        closeBottomPanelTimer.restart()
      }
    }

    Timer {
      id: closeBottomPanelTimer
      interval: 2000
      running: false
      repeat: false
      onTriggered: bottomPanel.openByChange = false
    }

    WorkspaceRow {
      anchors { top: bottomPanel.top; bottom: bottomPanel.bottom}
      anchors.horizontalCenter: bottomPanel.horizontalCenter
      width: bottomPanel.contentWidth

      opacity: bottomPanel.open ? 1 : 0

      Behavior on cellOffset {
        SequentialAnimation {
          PauseAnimation { duration: Config.anims.framePanelDuration * (1 - (bottomPanel.contentHeight) / Config.workspaces.slotHeight) }
          NumberAnimation { 
            easing.type: Config.anims.workspaceIndicatorCurve
            duration: Config.anims.workspaceIndicatorDuration
          }
        }
      }
    }
  }

  FramePanel {
    id: rightPanel

    direction: "right"
    openWidth: volume.width
    openHeight: volume.height

    Connections {
      target: Audio
      function onVolumeKeyPressed() { 
        rightPanel.openByChange = true
        closeRightPanelTimer.restart()
      }
    }

    onHoveredChanged: {
      if (!hovered) {
        closeRightPanelTimer.restart()
      }
    }

    Timer {
      id: closeRightPanelTimer
      interval: 2000
      running: false
      repeat: false
      onTriggered: { 
        if (volume.sliderPressed || rightPanel.hovered) {
          restart()
        } else {
          rightPanel.openByChange = false
        }
      }
    }

    Volume {
      id: volume
      anchors.verticalCenter: rightPanel.verticalCenter
      anchors.horizontalCenter: rightPanel.horizontalCenter
      opacity: rightPanel.open ? 1 : 0

      onSliderPressedChanged: {
        if (!sliderPressed) {
          closeRightPanelTimer.restart()
        }
      }
    }
  }
}

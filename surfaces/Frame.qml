import QtQuick
import Quickshell
import QtQuick.Shapes
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.config
import qs.components
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
    Region {
      item: bottomPanel 
    }
  }

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "qs"

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Shape {
    anchors.fill: parent
    ShapePath {
      id: frame
      fillColor: Qt.alpha(Colors.background, Colors.alpha)
      strokeWidth: -1

      property real innerBottomFrame: root.height - Config.frame.thickness
      property real innerRightFrame: root.width - Config.frame.thickness
      property real innerLeftFrame: Config.frame.thickness
      property real innerTopFrame: Config.frame.thickness

      property real frameCenterX: root.width / 2
      property real frameCenterY: root.height / 2

      property real bumpBaseWidth: bumpPlateauWidth + (Config.bottomPanel.travel * 2)
      property real bumpPlateauWidth: Config.bottomPanel.neutralWidth
      property real bumpHeight: Config.bottomPanel.neutralHeight
      property real bezierSoftness: Config.bottomPanel.curveSoftness

      startX: frame.innerLeftFrame + Config.frame.radius
      startY: frame.innerTopFrame

      PathLine { 
        x: frame.innerRightFrame - Config.frame.radius
        y: frame. innerTopFrame
      }

      PathArc {
        x: frame.innerRightFrame
        y: frame.innerTopFrame + Config.frame.radius
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathLine { 
        x: frame.innerRightFrame
        y: frame.innerBottomFrame - Config.frame.radius
      }

      PathArc {
        x: frame.innerRightFrame - Config.frame.radius
        y: frame.innerBottomFrame
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathLine {
        x: frame.frameCenterX + frame.bumpBaseWidth / 2
        y: frame.innerBottomFrame
      }

      // Bottom Bump
      PathCubic {
        x: frame.frameCenterX + (frame.bumpPlateauWidth / 2); 
        y: frame.innerBottomFrame - frame.bumpHeight
        control1X: frame.frameCenterX + (frame.bumpBaseWidth / 2) - frame.bezierSoftness; 
        control1Y: frame.innerBottomFrame
        control2X: frame.frameCenterX + (frame.bumpPlateauWidth / 2) + frame.bezierSoftness; 
        control2Y: frame.innerBottomFrame - frame.bumpHeight
      }

      PathLine {
        x: frame.frameCenterX - (frame.bumpPlateauWidth / 2)
        y: frame.innerBottomFrame - frame.bumpHeight
      }

      PathCubic {
        x: frame.frameCenterX - (frame.bumpBaseWidth / 2); y: frame.innerBottomFrame
        control1X: frame.frameCenterX - (frame.bumpPlateauWidth / 2) - frame.bezierSoftness; control1Y: frame.innerBottomFrame - frame.bumpHeight
        control2X: frame.frameCenterX - (frame.bumpBaseWidth / 2) + frame.bezierSoftness; control2Y: frame.innerBottomFrame
      }
      //

      PathLine { 
        x: frame.innerLeftFrame + Config.frame.radius
        y: frame.innerBottomFrame
      }

      PathArc {
        x: frame.innerLeftFrame
        y: frame.innerBottomFrame - Config.frame.radius
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathLine { 
        x: frame.innerLeftFrame
        y: frame.innerTopFrame + Config.frame.radius
      }

      PathArc {
        x: frame.innerLeftFrame + Config.frame.radius
        y: frame.innerTopFrame 
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathRectangle {
        width: root.width
        height: root.height
      }
    }
  }

  Item {
    id: bottomPanel
    property bool open: false

    x: frame.frameCenterX - (frame.bumpBaseWidth / 2); y: frame.innerBottomFrame - frame.bumpHeight
    width: frame.bumpBaseWidth; 
    height: root.height - bottomPanel.y

    states: [
      State {
        name: "hovered"
        when: !bottomPanel.open && mouse.hovered
        PropertyChanges { 
          target: frame; 
          bumpHeight: Config.bottomPanel.hoveredHeight
          bumpPlateauWidth: Config.bottomPanel.hoveredWidth
        }
      },
      State {
        name: "open"
        when: bottomPanel.open
        PropertyChanges { 
          target: frame; 
          bumpHeight: Config.workspaces.slotHeight
          bumpPlateauWidth: Config.workspaces.visibleSlots * Config.workspaces.slotWidth
        }
      }
    ]

    transitions: Transition {
      NumberAnimation { 
        properties: "bumpHeight, bumpPlateauWidth"; 
        easing.type: Config.anims.framePanelCurve
        duration: Config.anims.framePanelDuration
      }
    }

    Connections {
      target: FocusedWorkspace
      function onWsIdChanged() { 
        bottomPanel.open = true
        closePanelTimer.restart()
      }
    }

    Timer {
      id: closePanelTimer
      interval: 2000
      running: false
      repeat: false
      onTriggered: bottomPanel.open = false
    }

    TapHandler {
      onTapped: (eventPoint, button) => bottomPanel.open = true
    }

    HoverHandler {
      id: mouse
      acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
      cursorShape: Qt.PointingHandCursor
      onHoveredChanged: {
        if (!mouse.hovered) bottomPanel.open = false
      }
    }

    WorkspaceRow {
      anchors { top: bottomPanel.top; bottom: bottomPanel.bottom }
      anchors.horizontalCenter: bottomPanel.horizontalCenter
      width: frame.bumpPlateauWidth

      opacity: bottomPanel.open ? 1 : 0

      Behavior on opacity {
        NumberAnimation { 
          easing.type: Config.anims.fadeCurve
          duration: Config.anims.fadeDuration
        }
      }
      Behavior on cellOffset {
        SequentialAnimation {
          PauseAnimation { duration: Config.anims.framePanelDuration * (1 - (frame.bumpHeight) / Config.workspaces.slotHeight) }
          NumberAnimation { 
            easing.type: Config.anims.workspaceIndicatorCurve
            duration: Config.anims.workspaceIndicatorDuration
          }
        }
      }
    }
  }
}

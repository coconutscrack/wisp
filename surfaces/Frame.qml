import QtQuick
import Quickshell
import QtQuick.Shapes
import Quickshell.Wayland
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

      // property real baseWidth: Config.bottomPanel.width + (Config.bottomPanel.radius * 2)
      // property real plateauWidth: Config.bottomPanel.width - (Config.bottomPanel.radius * 2)
      // property real verticalHeight: Config.bottomPanel.height - (Config.bottomPanel.radius * 2)

      property real baseWidth: bottomPanel.bumpWidth + (bottomPanel.bumpRadius * 2)
      property real plateauWidth: bottomPanel.bumpWidth - (bottomPanel.bumpRadius * 2)
      property real verticalHeight: bottomPanel.bumpHeight - (bottomPanel.bumpRadius * 2)

      startX: frame.innerLeftFrame + Config.frame.radius
      startY: frame.innerTopFrame

      PathLine { 
        x: frame.innerRightFrame - Config.frame.radius
        y: frame.innerTopFrame
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
        x: frame.frameCenterX + frame.baseWidth / 2
        y: frame.innerBottomFrame
      }

      // Bottom Bump
      PathArc {
        x: frame.frameCenterX + bottomPanel.bumpWidth / 2
        y: frame.innerBottomFrame - bottomPanel.bumpRadius;
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
      }

      PathLine {
        x: frame.frameCenterX + (bottomPanel.bumpWidth / 2)
        y: frame.innerBottomFrame - frame.verticalHeight - bottomPanel.bumpRadius
      }

      PathArc {
        x: frame.frameCenterX + (frame.plateauWidth / 2);
        y: frame.innerBottomFrame - bottomPanel.bumpHeight 
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        x: frame.frameCenterX - (frame.plateauWidth / 2)
        y: frame.innerBottomFrame - bottomPanel.bumpHeight
      }

      PathArc {
        x: frame.frameCenterX - (frame.plateauWidth / 2) - bottomPanel.bumpRadius;
        y: frame.innerBottomFrame - bottomPanel.bumpHeight + bottomPanel.bumpRadius
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        x: frame.frameCenterX - (frame.plateauWidth / 2) - bottomPanel.bumpRadius
        y: frame.innerBottomFrame - bottomPanel.bumpRadius
      }

      PathArc {
        x: frame.frameCenterX - (frame.baseWidth / 2); 
        y: frame.innerBottomFrame
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
      }

      ////////////////////////

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
    property real contentWidth: Config.workspaces.slotWidth * Config.workspaces.visibleSlots
    property real contentHeight: 0
    property real padding: bumpRadius
    property real bumpHeight: contentHeight + padding * 2
    property real bumpWidth: contentWidth + padding * 2
    property real bumpRadius: { 
      let tmp_r = (contentWidth < contentHeight ? contentWidth / 2 : contentHeight / 2) 
      tmp_r > Config.frame.radius ? Config.frame.radius : tmp_r 
    }

    x: frame.frameCenterX - (bottomPanel.bumpWidth / 2); y: frame.innerBottomFrame - bottomPanel.bumpHeight
    width: bottomPanel.bumpWidth; 
    height: root.height - bottomPanel.y

    states: [
      State {
        name: "open"
        when: bottomPanel.open
        PropertyChanges { 
          target: bottomPanel; 
          contentHeight: Config.workspaces.slotHeight
        }
      }
    ]

    transitions: Transition {
      NumberAnimation { 
        properties: "contentHeight"; 
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

    WorkspaceRow {
      anchors { top: bottomPanel.top }
      anchors.horizontalCenter: bottomPanel.horizontalCenter
      width: bottomPanel.contentWidth
      height: bottomPanel.bumpHeight

      opacity: bottomPanel.open ? 1 : 0

      Behavior on opacity {
        NumberAnimation { 
          easing.type: Config.anims.fadeCurve
          duration: Config.anims.fadeDuration
        }
      }
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
}

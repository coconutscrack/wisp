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

    ShapePath {
      id: frame
      fillColor: Qt.alpha(Colors.background, Colors.alpha)
      strokeWidth: -1

      property real innerBottomEdge: root.height - Config.frame.thickness
      property real innerRightEdge: root.width - Config.frame.thickness
      property real innerLeftEdge: Config.frame.thickness
      property real innerTopEdge: Config.frame.thickness

      property real middleX: root.width / 2
      property real middleY: root.height / 2

      property real topBaseWidth: topPanel.bumpWidth + (topPanel.bumpRadius * 2)
      property real topPlateauWidth: topPanel.bumpWidth - (topPanel.bumpRadius * 2)
      property real topVerticalHeight: topPanel.bumpHeight - (topPanel.bumpRadius * 2)

      property real bottomBaseWidth: bottomPanel.bumpWidth + (bottomPanel.bumpRadius * 2)
      property real bottomPlateauWidth: bottomPanel.bumpWidth - (bottomPanel.bumpRadius * 2)
      property real bottomVerticalHeight: bottomPanel.bumpHeight - (bottomPanel.bumpRadius * 2)

      property real rightBaseHeight: rightPanel.bumpHeight + (rightPanel.bumpRadius * 2)
      property real rightPlateauHeight: rightPanel.bumpHeight - (rightPanel.bumpRadius * 2)
      property real rightHorizontalWidth: rightPanel.bumpWidth - (rightPanel.bumpRadius * 2)



      startX: frame.innerLeftEdge + Config.frame.radius
      startY: frame.innerTopEdge

      // top left line
      PathLine { 
        x: frame.middleX - (frame.topBaseWidth / 2)
        y: frame.innerTopEdge
      }

      PathArc {
        x: frame.middleX - (topPanel.bumpWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpRadius
        radiusX: topPanel.bumpRadius
        radiusY: topPanel.bumpRadius
      }

      PathLine { 
        x: frame.middleX - (topPanel.bumpWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpRadius + frame.topVerticalHeight
      }

      PathArc {
        x: frame.middleX - (frame.topPlateauWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpHeight
        radiusX: topPanel.bumpRadius
        radiusY: topPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine { 
        x: frame.middleX + (frame.topPlateauWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpHeight
      }

      PathArc {
        x: frame.middleX + (topPanel.bumpWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpRadius + frame.topVerticalHeight
        radiusX: topPanel.bumpRadius
        radiusY: topPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine { 
        x: frame.middleX + (topPanel.bumpWidth / 2)
        y: frame.innerTopEdge + topPanel.bumpRadius
      }

      PathArc {
        x: frame.middleX + (topPanel.bumpWidth / 2) + topPanel.bumpRadius
        y: frame.innerTopEdge
        radiusX: topPanel.bumpRadius
        radiusY: topPanel.bumpRadius
      }

      // top right line
      PathLine { 
        x: frame.innerRightEdge - Config.frame.radius
        y: frame.innerTopEdge
      }

      PathArc {
        x: frame.innerRightEdge
        y: frame.innerTopEdge + Config.frame.radius
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathLine { 
        x: frame.innerRightEdge
        y: frame.middleY - frame.rightBaseHeight / 2
      }

      PathArc {
        x: frame.innerRightEdge - rightPanel.bumpRadius
        y: frame.middleY - (frame.rightBaseHeight / 2) + rightPanel.bumpRadius
        radiusX: rightPanel.bumpRadius
        radiusY: rightPanel.bumpRadius
      }

      PathLine { 
        x: frame.innerRightEdge - frame.rightHorizontalWidth - rightPanel.bumpRadius
        y: frame.middleY - rightPanel.bumpHeight / 2
      }

      PathArc {
        x: frame.innerRightEdge - rightPanel.bumpWidth
        y: frame.middleY - (rightPanel.bumpHeight / 2) + rightPanel.bumpRadius
        radiusX: rightPanel.bumpRadius
        radiusY: rightPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        x: frame.innerRightEdge - rightPanel.bumpWidth
        y: frame.middleY + (rightPanel.bumpHeight / 2) - rightPanel.bumpRadius
      }

      PathArc {
        x: frame.innerRightEdge - rightPanel.bumpWidth + rightPanel.bumpRadius
        y: frame.middleY + (rightPanel.bumpHeight / 2)
        radiusX: rightPanel.bumpRadius
        radiusY: rightPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine { 
        x: frame.innerRightEdge - rightPanel.bumpRadius
        y: frame.middleY + (rightPanel.bumpHeight / 2)
      }

      PathArc {
        x: frame.innerRightEdge
        y: frame.middleY + (frame.rightBaseHeight / 2)
        radiusX: rightPanel.bumpRadius
        radiusY: rightPanel.bumpRadius
      }

      PathLine { 
        x: frame.innerRightEdge
        y: frame.innerBottomEdge - Config.frame.radius
      }

      PathArc {
        x: frame.innerRightEdge - Config.frame.radius
        y: frame.innerBottomEdge
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      PathLine {
        x: frame.middleX + frame.bottomBaseWidth / 2
        y: frame.innerBottomEdge
      }

      // bottom bump
      PathArc {
        x: frame.middleX + bottomPanel.bumpWidth / 2
        y: frame.innerBottomEdge - bottomPanel.bumpRadius
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
      }

      PathLine {
        x: frame.middleX + (bottomPanel.bumpWidth / 2)
        y: frame.innerBottomEdge - frame.bottomVerticalHeight - bottomPanel.bumpRadius
      }

      PathArc {
        x: frame.middleX + (frame.bottomPlateauWidth / 2)
        y: frame.innerBottomEdge - bottomPanel.bumpHeight 
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        x: frame.middleX - (frame.bottomPlateauWidth / 2)
        y: frame.innerBottomEdge - bottomPanel.bumpHeight
      }

      PathArc {
        x: frame.middleX - (frame.bottomPlateauWidth / 2) - bottomPanel.bumpRadius
        y: frame.innerBottomEdge - bottomPanel.bumpHeight + bottomPanel.bumpRadius
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        x: frame.middleX - (frame.bottomPlateauWidth / 2) - bottomPanel.bumpRadius
        y: frame.innerBottomEdge - bottomPanel.bumpRadius
      }

      PathArc {
        x: frame.middleX - (frame.bottomBaseWidth / 2)
        y: frame.innerBottomEdge
        radiusX: bottomPanel.bumpRadius
        radiusY: bottomPanel.bumpRadius
      }

      // bottom left line
      PathLine { 
        x: frame.innerLeftEdge + Config.frame.radius
        y: frame.innerBottomEdge
      }

      // bottom left arc
      PathArc {
        x: frame.innerLeftEdge
        y: frame.innerBottomEdge - Config.frame.radius
        radiusX: Config.frame.radius
        radiusY: Config.frame.radius
      }

      // left line
      PathLine { 
        x: frame.innerLeftEdge
        y: frame.innerTopEdge + Config.frame.radius
      }

      // top left arc
      PathArc {
        x: frame.innerLeftEdge + Config.frame.radius
        y: frame.innerTopEdge 
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
    id: topPanel
    property bool open: false
    property real contentWidth: 0
    property real contentHeight: 0
    property real padding: bumpRadius
    property real bumpHeight: { Math.max(contentHeight + padding * 2 - Config.frame.thickness, 0) }
    property real bumpWidth: contentWidth + padding * 2
    property real bumpRadius: { 
      let tmp_r = (contentWidth < contentHeight ? contentWidth / 2 : contentHeight / 2) 
      tmp_r > Config.frame.radius ? Config.frame.radius : tmp_r 
    }

    x: frame.middleX - (topPanel.bumpWidth / 2); 
    y: 0
    width: topPanel.bumpWidth; 
    height: frame.innerTopEdge + bumpHeight

    states: [
      State {
        name: "open"
        when: topPanel.open || OverlayStatus.open
        PropertyChanges { 
          target: topPanel; 
          contentHeight: clock.height
          contentWidth: clock.width
        }
      }
    ]

    transitions: Transition {
      NumberAnimation { 
        properties: "contentHeight, contentWidth"; 
        easing.type: Config.anims.framePanelCurve
        duration: Config.anims.framePanelDuration
      }
    }

    Timer {
      id: closeTopPanelTimer
      interval: 2000
      running: false
      repeat: false
      onTriggered: topPanel.open = false
    }

    Clock {
      id: clock
      opacity: topPanel.open || OverlayStatus.open ? 1 : 0
      anchors.verticalCenter: topPanel.verticalCenter
      anchors.horizontalCenter: topPanel.horizontalCenter
    }
  }

  FramePanel {
    id: bottomPanel

    direction: "bottom"
    openHeight: Config.workspaces.slotHeight
    openWidth: Config.workspaces.slotWidth * Config.workspaces.visibleSlots
    openByOverlay: OverlayStatus.open

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
      onTriggered: bottomPanel.open = false
    }

    WorkspaceRow {
      id: workspaceRow
      anchors { top: bottomPanel.top; bottom: bottomPanel.bottom}
      anchors.horizontalCenter: bottomPanel.horizontalCenter
      width: bottomPanel.contentWidth

      opacity: open ? 1 : 0

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

  Item {
    id: rightPanel
    property bool open: false
    property real contentWidth: 0
    property real contentHeight: 0
    property real padding: bumpRadius
    property real bumpHeight: contentHeight + padding * 2
    property real bumpWidth: { Math.max(contentWidth + (padding * 2) - Config.frame.thickness, 0) }
    property real bumpRadius: { 
      let tmp_r = (contentWidth < contentHeight ? contentWidth / 2 : contentHeight / 2) 
      tmp_r > Config.frame.radius ? Config.frame.radius : tmp_r 
    }

    x: frame.innerRightEdge - bumpWidth
    y: frame.middleY - (rightPanel.bumpHeight / 2);
    width: rightPanel.bumpWidth + Config.frame.thickness; 
    height: bumpHeight

    states: [
      State {
        name: "open"
        when: rightPanel.open || OverlayStatus.open
        PropertyChanges { 
          target: rightPanel; 
          contentHeight: volume.height
          contentWidth: volume.width
        }
      }
    ]

    transitions: Transition {
      NumberAnimation { 
        properties: "contentHeight, contentWidth"; 
        easing.type: Config.anims.framePanelCurve
        duration: Config.anims.framePanelDuration
      }
    }

    Connections {
      target: Audio
      function onVolumeChanged() { 
        rightPanel.open = true
        closeRightPanelTimer.restart()
      }
    }

    Timer {
      id: closeRightPanelTimer
      interval: 2000
      running: false
      repeat: false
      onTriggered: { 
        if (volume.sliderPressed) {
          restart()
        } else {
          rightPanel.open = false
        }
      }
    }

    Volume {
      id: volume
      anchors.verticalCenter: rightPanel.verticalCenter
      anchors.horizontalCenter: rightPanel.horizontalCenter
      opacity: rightPanel.open || OverlayStatus.open ? 1 : 0

      onSliderPressedChanged: {
        if (!sliderPressed) {
          closeRightPanelTimer.restart()
        }
      }
    }
  }
}

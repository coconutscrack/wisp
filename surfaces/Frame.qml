import QtQuick
import Quickshell
import QtQuick.Shapes
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
    Region {
      item: bottomPanel 
    }
  }

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "qs"

  // BackgroundEffect.blurRegion: Region { 
  //   width: root.width
  //   height: root.height
  //   Region {
  //     x: frame.innerLeftFrame - 1; y: frame.innerTopFrame - 1;
  //     width: root.width - (Sizes.frameThickness * 2) + 2; height: root.height - (Sizes.frameThickness * 2) + 2;
  //     intersection: Intersection.Subtract
  //     radius: Sizes.frameRadius
  //   }
  // }

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Item {
    id: bottomPanel
    x: frame.frameCenterX - (frame.bumpBaseWidth / 2); y: frame.innerBottomFrame - frame.bumpHeight
    width: frame.bumpBaseWidth; 
    height: root.height - bottomPanel.y

    states: [
      State {
        name: "hovered"
        when: mouse.hovered
        PropertyChanges { 
          target: frame; 
          bumpHeight: 12
          bumpBaseWidth: 80
          bumpPlateauWidth: 40
        }
      }
    ]

    transitions: Transition {
      NumberAnimation { 
        properties: "bumpHeight, bumpBaseWidth, bumpPlateauWidth"; 
        easing.type: Easing.InOutQuad
        duration: 150
      }
    }

    HoverHandler {
      id: mouse
      acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
      cursorShape: Qt.PointingHandCursor
    }
  }

  Shape {
    anchors.fill: parent
    ShapePath {
      id: frame
      fillColor: Qt.alpha(Colors.background, Colors.alpha)
      strokeWidth: -1

      property real innerBottomFrame: root.height - Sizes.frameThickness
      property real innerRightFrame: root.width - Sizes.frameThickness
      property real innerLeftFrame: Sizes.frameThickness
      property real innerTopFrame: Sizes.frameThickness

      property real frameCenterX: root.width / 2
      property real frameCenterY: root.height / 2

      property real bumpBaseWidth: 70
      property real bumpPlateauWidth: 30
      property real bumpHeight: 9
      property real bezierSoftness: 15

      startX: frame.innerLeftFrame + Sizes.frameRadius
      startY: frame.innerTopFrame

      PathLine { 
        x: frame.innerRightFrame - Sizes.frameRadius
        y: frame. innerTopFrame
      }

      PathArc {
        x: frame.innerRightFrame
        y: frame.innerTopFrame + Sizes.frameRadius
        radiusX: Sizes.frameRadius
        radiusY: Sizes.frameRadius
      }

      PathLine { 
        x: frame.innerRightFrame
        y: frame.innerBottomFrame - Sizes.frameRadius
      }

      PathArc {
        x: frame.innerRightFrame - Sizes.frameRadius
        y: frame.innerBottomFrame
        radiusX: Sizes.frameRadius
        radiusY: Sizes.frameRadius
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
        x: frame.innerLeftFrame + Sizes.frameRadius
        y: frame.innerBottomFrame
      }

      PathArc {
        x: frame.innerLeftFrame
        y: frame.innerBottomFrame - Sizes.frameRadius
        radiusX: Sizes.frameRadius
        radiusY: Sizes.frameRadius
      }

      PathLine { 
        x: frame.innerLeftFrame
        y: frame.innerTopFrame + Sizes.frameRadius
      }

      PathArc {
        x: frame.innerLeftFrame + Sizes.frameRadius
        y: frame.innerTopFrame 
        radiusX: Sizes.frameRadius
        radiusY: Sizes.frameRadius
      }

      PathRectangle {
        width: root.width
        height: root.height
      }
    }
  }
}

import QtQuick
import Quickshell
import QtQuick.Shapes
import qs.config

PanelWindow {
  id: root

  anchors {
    top: true
    bottom : true
    left: true
    right: true
  }
  mask: Region {}
  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  Shape {
    anchors.fill: parent
    ShapePath {
      id: frame
      fillColor: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, Colors.alpha)
      strokeWidth: -1

      property real innerBottomFrame: root.height - Sizes.frameThickness
      property real innerRightFrame: root.width - Sizes.frameThickness
      property real innerLeftFrame: Sizes.frameThickness
      property real innerTopFrame: Sizes.frameThickness

      property real frameCenterX: root.width / 2
      property real frameCenterY: root.height / 2

      property real neutralBumpBaseWidth: 100
      property real neutralBumpPlateauWidth: 70
      property real neutralBumpHeight: 6
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
        x: frame.frameCenterX + frame.neutralBumpBaseWidth / 2
        y: frame.innerBottomFrame
      }

      // Bottom Bump
      // PathArc {
      //   x: frame.frameCenterX + 25
      //   y: frame.innerBottomFrame - 3
      //   radiusX: 100
      //   radiusY: 100
      // }

      // PathLine {
      //   x: frame.frameCenterX + 20
      //   y: frame.innerBottomFrame - 6
      // }

      // PathArc {
      //   x: frame.frameCenterX + 15
      //   y: frame.innerBottomFrame - 9
      //   radiusX: Sizes.frameRadius
      //   radiusY: Sizes.frameRadius
      //   direction: PathArc.Counterclockwise
      // }
      PathCubic {
        x: frame.frameCenterX + (frame.neutralBumpPlateauWidth / 2); 
        y: frame.innerBottomFrame - frame.neutralBumpHeight
        control1X: frame.frameCenterX + (frame.neutralBumpBaseWidth / 2) - frame.bezierSoftness; 
        control1Y: frame.innerBottomFrame
        control2X: frame.frameCenterX + (frame.neutralBumpPlateauWidth / 2) + frame.bezierSoftness; 
        control2Y: frame.innerBottomFrame - frame.neutralBumpHeight
      }

      PathLine {
        x: frame.frameCenterX - (frame.neutralBumpPlateauWidth / 2)
        y: frame.innerBottomFrame - frame.neutralBumpHeight
      }

      PathCubic {
        x: frame.frameCenterX - (frame.neutralBumpBaseWidth / 2); y: frame.innerBottomFrame
        control1X: frame.frameCenterX - (frame.neutralBumpPlateauWidth / 2) - frame.bezierSoftness; control1Y: frame.innerBottomFrame - frame.neutralBumpHeight
        control2X: frame.frameCenterX - (frame.neutralBumpBaseWidth / 2) + frame.bezierSoftness; control2Y: frame.innerBottomFrame
      }

      // PathArc {
      //   x: frame.frameCenterX - 25
      //   y: frame.innerBottomFrame - 3
      //   radiusX: Sizes.frameRadius
      //   radiusY: Sizes.frameRadius
      //   direction: PathArc.Counterclockwise
      // }

      // PathLine {
      //   x: frame.frameCenterX - 25
      //   y: frame.innerBottomFrame - 3
      // }

      // PathArc {
      //   x: frame.frameCenterX - 35
      //   y: frame.innerBottomFrame
      //   radiusX: 100
      //   radiusY: 100
      // }

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

import QtQuick
import QtQuick.Shapes
import qs.config

ShapePath {
  id: frame

  strokeWidth: -1

  required property real outerWidth
  required property real outerHeight
  required property FramePanel topPanel
  required property FramePanel bottomPanel
  required property FramePanel rightPanel

  property real innerBottomEdge: outerHeight - Config.frame.thickness
  property real innerRightEdge: outerWidth - Config.frame.thickness
  property real innerLeftEdge: Config.frame.thickness
  property real innerTopEdge: Config.frame.thickness

  property real middleX: outerWidth / 2
  property real middleY: outerHeight / 2

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
}

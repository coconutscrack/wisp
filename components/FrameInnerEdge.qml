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
  required property FramePanel leftPanel
  required property FramePanel rightPanel

  property real innerBottomEdge: outerHeight - Config.frame.thickness
  property real innerRightEdge: outerWidth - Config.frame.thickness
  property real innerLeftEdge: Config.frame.thickness
  property real innerTopEdge: Config.frame.thickness

  property real middleX: outerWidth / 2
  property real middleY: outerHeight / 2

  property real topBaseWidth: topPanel.bumpWidth + (topPanel.arcRadius * 2)
  property real topPlateauWidth: topPanel.bumpWidth - (topPanel.arcRadius * 2)
  property real topVerticalHeight: topPanel.bumpHeight - (topPanel.arcRadius * 2)

  property real bottomBaseWidth: bottomPanel.bumpWidth + (bottomPanel.arcRadius * 2)
  property real bottomPlateauWidth: bottomPanel.bumpWidth - (bottomPanel.arcRadius * 2)
  property real bottomVerticalHeight: bottomPanel.bumpHeight - (bottomPanel.arcRadius * 2)

  property real leftBaseHeight: leftPanel.bumpHeight + (leftPanel.arcRadius * 2)
  property real leftPlateauHeight: leftPanel.bumpHeight - (leftPanel.arcRadius * 2)
  property real leftHorizontalWidth: leftPanel.bumpWidth - (leftPanel.arcRadius * 2)

  property real rightBaseHeight: rightPanel.bumpHeight + (rightPanel.arcRadius * 2)
  property real rightPlateauHeight: rightPanel.bumpHeight - (rightPanel.arcRadius * 2)
  property real rightHorizontalWidth: rightPanel.bumpWidth - (rightPanel.arcRadius * 2)

  startX: frame.innerLeftEdge + Config.frame.radius
  startY: frame.innerTopEdge

  // top left line
  PathLine { 
    x: frame.middleX - (frame.topBaseWidth / 2)
    y: frame.innerTopEdge
  }

  PathArc {
    x: frame.middleX - (topPanel.bumpWidth / 2)
    y: frame.innerTopEdge + topPanel.arcRadius
    radiusX: topPanel.arcRadius
    radiusY: topPanel.arcRadius
  }

  PathLine { 
    x: frame.middleX - (topPanel.bumpWidth / 2)
    y: frame.innerTopEdge + topPanel.arcRadius + frame.topVerticalHeight
  }

  PathArc {
    x: frame.middleX - (frame.topPlateauWidth / 2)
    y: frame.innerTopEdge + topPanel.bumpHeight
    radiusX: topPanel.arcRadius
    radiusY: topPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine { 
    x: frame.middleX + (frame.topPlateauWidth / 2)
    y: frame.innerTopEdge + topPanel.bumpHeight
  }

  PathArc {
    x: frame.middleX + (topPanel.bumpWidth / 2)
    y: frame.innerTopEdge + topPanel.arcRadius + frame.topVerticalHeight
    radiusX: topPanel.arcRadius
    radiusY: topPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine { 
    x: frame.middleX + (topPanel.bumpWidth / 2)
    y: frame.innerTopEdge + topPanel.arcRadius
  }

  PathArc {
    x: frame.middleX + (topPanel.bumpWidth / 2) + topPanel.arcRadius
    y: frame.innerTopEdge
    radiusX: topPanel.arcRadius
    radiusY: topPanel.arcRadius
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
    x: frame.innerRightEdge - rightPanel.arcRadius
    y: frame.middleY - (frame.rightBaseHeight / 2) + rightPanel.arcRadius
    radiusX: rightPanel.arcRadius
    radiusY: rightPanel.arcRadius
  }

  PathLine { 
    x: frame.innerRightEdge - frame.rightHorizontalWidth - rightPanel.arcRadius
    y: frame.middleY - rightPanel.bumpHeight / 2
  }

  PathArc {
    x: frame.innerRightEdge - rightPanel.bumpWidth
    y: frame.middleY - (rightPanel.bumpHeight / 2) + rightPanel.arcRadius
    radiusX: rightPanel.arcRadius
    radiusY: rightPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine {
    x: frame.innerRightEdge - rightPanel.bumpWidth
    y: frame.middleY + (rightPanel.bumpHeight / 2) - rightPanel.arcRadius
  }

  PathArc {
    x: frame.innerRightEdge - rightPanel.bumpWidth + rightPanel.arcRadius
    y: frame.middleY + (rightPanel.bumpHeight / 2)
    radiusX: rightPanel.arcRadius
    radiusY: rightPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine { 
    x: frame.innerRightEdge - rightPanel.arcRadius
    y: frame.middleY + (rightPanel.bumpHeight / 2)
  }

  PathArc {
    x: frame.innerRightEdge
    y: frame.middleY + (frame.rightBaseHeight / 2)
    radiusX: rightPanel.arcRadius
    radiusY: rightPanel.arcRadius
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
    y: frame.innerBottomEdge - bottomPanel.arcRadius
    radiusX: bottomPanel.arcRadius
    radiusY: bottomPanel.arcRadius
  }

  PathLine {
    x: frame.middleX + (bottomPanel.bumpWidth / 2)
    y: frame.innerBottomEdge - frame.bottomVerticalHeight - bottomPanel.arcRadius
  }

  PathArc {
    x: frame.middleX + (frame.bottomPlateauWidth / 2)
    y: frame.innerBottomEdge - bottomPanel.bumpHeight 
    radiusX: bottomPanel.arcRadius
    radiusY: bottomPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine {
    x: frame.middleX - (frame.bottomPlateauWidth / 2)
    y: frame.innerBottomEdge - bottomPanel.bumpHeight
  }

  PathArc {
    x: frame.middleX - (frame.bottomPlateauWidth / 2) - bottomPanel.arcRadius
    y: frame.innerBottomEdge - bottomPanel.bumpHeight + bottomPanel.arcRadius
    radiusX: bottomPanel.arcRadius
    radiusY: bottomPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine {
    x: frame.middleX - (frame.bottomPlateauWidth / 2) - bottomPanel.arcRadius
    y: frame.innerBottomEdge - bottomPanel.arcRadius
  }

  PathArc {
    x: frame.middleX - (frame.bottomBaseWidth / 2)
    y: frame.innerBottomEdge
    radiusX: bottomPanel.arcRadius
    radiusY: bottomPanel.arcRadius
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

  // bottom left line
  PathLine { 
    x: frame.innerLeftEdge
    y: frame.middleY + frame.leftBaseHeight / 2
  }

  PathArc {
    x: frame.innerLeftEdge + leftPanel.arcRadius
    y: frame.middleY + leftPanel.bumpHeight / 2
    radiusX: leftPanel.arcRadius
    radiusY: leftPanel.arcRadius
  }

  PathLine {
    x: frame.innerLeftEdge + leftPanel.arcRadius + frame.leftHorizontalWidth
    y: frame.middleY + leftPanel.bumpHeight / 2
  }

  PathArc {
    x: frame.innerLeftEdge + leftPanel.bumpWidth
    y: frame.middleY + frame.leftPlateauHeight / 2
    radiusX: leftPanel.arcRadius
    radiusY: leftPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine {
    x: frame.innerLeftEdge + leftPanel.bumpWidth
    y: frame.middleY - frame.leftPlateauHeight / 2
  }

  PathArc {
    x: frame.innerLeftEdge + leftPanel.bumpWidth - leftPanel.arcRadius
    y: frame.middleY - leftPanel.bumpHeight / 2
    radiusX: leftPanel.arcRadius
    radiusY: leftPanel.arcRadius
    direction: PathArc.Counterclockwise
  }

  PathLine {
    x: frame.innerLeftEdge + leftPanel.arcRadius
    y: frame.middleY - leftPanel.bumpHeight / 2
  }

  PathArc {
    x: frame.innerLeftEdge
    y: frame.middleY - frame.leftBaseHeight / 2
    radiusX: leftPanel.arcRadius
    radiusY: leftPanel.arcRadius
  }

  // top left line
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

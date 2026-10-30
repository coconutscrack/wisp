import Quickshell
import QtQuick
import qs.config

PanelWindow {
  required property string direction
  id: root
  exclusiveZone: Sizes.frameThickness

  mask: Region {}

  anchors {
    top: direction !== "bottom"
    bottom: direction !== "top"
    left: direction !== "right"
    right: direction !== "left"
  }

  implicitHeight: direction === "top" || direction === "bottom" ? Sizes.frameThickness : 0
  implicitWidth:  direction === "left" || direction === "right" ? Sizes.frameThickness : 0
  color: "transparent"
}

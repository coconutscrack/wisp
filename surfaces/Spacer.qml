import Quickshell
import QtQuick
import qs.config

PanelWindow {
  required property string direction
  exclusiveZone: Config.frame.thickness

  mask: Region {}

  anchors {
    top: direction !== "bottom"
    bottom: direction !== "top"
    left: direction !== "right"
    right: direction !== "left"
  }

  implicitHeight: direction === "top" || direction === "bottom" ? Config.frame.thickness : 0
  implicitWidth:  direction === "left" || direction === "right" ? Config.frame.thickness : 0
  color: "transparent"
}

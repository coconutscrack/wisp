pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property color background: "#0D0D0D"
  property color surface:    "#EADFCC"
  property color border:     "#D3C3AA"
  property color textMuted:  Qt.alpha(text, 0.5)
  property color text:       "#FFC799"
  property color accent:     "#B98557"
  property color success:    "#8DA287"
  property color warning:    "#C9A15B"
  property color critical:   "#BF6F5E"
  property real  alpha:      1
}

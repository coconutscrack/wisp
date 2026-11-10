pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property color background:    "#000000"
  property color surface:       "#1A1A1A"
  property color border:        "#2E2E2E"
  property color textMuted:     Qt.alpha(text, 0.5)
  property color text:          "#FFC799"
  property color accent:        "#B98557"
  property color success:       "#8DA287"
  property color warning:       "#C9A15B"
  property color critical:      "#BF6F5E"
  property color shadow:        "#000000"
  property real  alpha:         1
  property real  overlayAlpha:  0.5
}

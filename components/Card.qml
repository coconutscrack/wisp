import Quickshell
import QtQuick
import QtQuick.Effects
import qs.config

Rectangle {
  radius: Config.card.outerRadius
  width: 200
  height: 200
  layer.samples: 4
  layer.enabled: true
  layer.effect: MultiEffect {
    autoPaddingEnabled: true
    blurMax: 16
    shadowColor: Qt.alpha(Colors.shadow, 0.5)
    shadowEnabled: true
    shadowBlur: 1.0
  }
}

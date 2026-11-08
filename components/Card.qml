import Quickshell
import QtQuick
import QtQml
import QtQuick.Effects
import qs.config

Rectangle {
  required property Component neutralComponent
  required property Component expandedComponent
  readonly property bool hasQuickAction: typeof quickAction == 'function'
  property var quickAction
  property bool expanded
  property real expandedWidth
  property real expandedHeight
  radius: Config.card.outerRadius
  Loader {
    anchors.centerIn: parent
    sourceComponent: expanded ? expandedComponent : neutralComponent
  }
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
  color: Colors.background
  Behavior on width {
    NumberAnimation { 
      easing.type: Config.anims.cardStateCurve
      duration: Config.anims.cardStateDuration
    }
  }
  Behavior on height {
    NumberAnimation { 
      easing.type: Config.anims.cardStateCurve
      duration: Config.anims.cardStateDuration
    }
  }
}

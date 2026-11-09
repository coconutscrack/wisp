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
  radius: Config.card.outerRadius
  Loader {
    id: loader
    anchors.centerIn: parent
    sourceComponent: expanded ? expandedComponent : neutralComponent
  }
  anchors.verticalCenter: parent.verticalCenter
  width: expanded ? loader.width + Config.card.padding * 2 : Config.card.size
  height: expanded ? loader.height + Config.card.padding * 2 : Config.card.size
  layer.samples: 4
  layer.enabled: true
  layer.effect: MultiEffect {
    autoPaddingEnabled: true
    blurMax: 16
    shadowColor: Qt.alpha(Colors.shadow, 0.5)
    shadowEnabled: true
    shadowBlur: 1.0
  }
  color: Colors.surface
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

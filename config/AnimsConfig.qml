import Quickshell
import QtQuick

QtObject {
  property int framePanelCurve: Easing.InOutQuad
  property int framePanelDuration: 150
  property int workspaceIndicatorCurve: Easing.InOutQuad
  property int workspaceIndicatorDuration: 150
  property int fadeCurve: Easing.InOutQuad
  property int fadeDuration: 150
  property int sliderCurve: Easing.Linear
  property int sliderDuration: 150
}

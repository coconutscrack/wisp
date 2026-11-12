import Quickshell
import QtQuick

QtObject {
  property int framePanelCurve: Easing.InOutQuad
  property int framePanelDuration: 150
  property int workspaceIndicatorCurve: Easing.InOutQuad
  property int workspaceIndicatorDuration: 150
  property int carouselCurve: Easing.OutCubic
  property int carouselDuration: 150
  property int fadeCurve: Easing.InOutQuad
  property int fadeDuration: 150
  property int colorCurve: Easing.Linear
  property int colorDuration: 50
  property int sliderCurve: Easing.Linear
  property int sliderDuration: 150
  property int cardStateCurve: Easing.OutCubic
  property int cardStateDuration: 150
  property int powerConfCurve: Easing.Linear
  property int powerConfDuration: 100
}

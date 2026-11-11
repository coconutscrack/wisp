import QtQuick
import qs.config

Column {
  property alias sliderPressed: slider.pressed

  spacing: 10

  BrightnessIcon {
    anchors.horizontalCenter: parent.horizontalCenter
    height: slider.width
    width: slider.width
    fontSize: slider.width
  }

  BrightnessSlider {
    id: slider
    anchors.horizontalCenter: parent.horizontalCenter
  }

  Behavior on opacity {
    NumberAnimation { 
      easing.type: Config.anims.fadeCurve
      duration: Config.anims.fadeDuration
    }
  }
}

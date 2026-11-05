import QtQuick
import Quickshell
import qs.config
import qs.services

Text {
  id: root
  property string dateFormat: {
    return Config.clock.showSeconds ? "ddd d MMM | hh:mm:ss": "ddd d MMM | hh:mm"
  }
  horizontalAlignment: Text.AlignHCenter

  text: Qt.formatDateTime(Time.date, dateFormat)
  font.family: Fonts.text
  color: Colors.text
  font.pixelSize: Config.clock.fontSize
  height: { (Math.ceil(((font.pixelSize * 1.2) * Screen.devicePixelRatio) / 2) * 2) / Screen.devicePixelRatio }
  width: { (Math.ceil(((textMetrics.width * 1.2) * Screen.devicePixelRatio) / 2) * 2) / Screen.devicePixelRatio }

  TextMetrics {
    id: textMetrics
    font: root.font
    text: root.text
  }
  Behavior on opacity {
    NumberAnimation { 
      easing.type: Config.anims.fadeCurve
      duration: Config.anims.fadeDuration
    }
  }
}

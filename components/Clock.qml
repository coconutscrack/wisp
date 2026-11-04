import QtQuick
import Quickshell
import qs.config
import qs.services

Text {
  id: root
  property string dateFormat: {
    return Config.clock.showSeconds ? "ddd dd MMM | hh:mm:ss": "ddd d MMM | hh:mm"
  }
  horizontalAlignment: Text.AlignHCenter

  text: Qt.formatDateTime(Time.date, dateFormat)
  font.family: Fonts.text
  color: Colors.text
  font.pixelSize: Config.clock.fontSize
  lineHeight: 0.1
  height: font.pixelSize * 1.2
  width: textMetrics.width * 1.2

  TextMetrics {
    id: textMetrics
    font: root.font
    text: root.text
  }
}

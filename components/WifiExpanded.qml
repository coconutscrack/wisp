import Quickshell
import QtQuick
import qs.services
import qs.config

ListView {
  Component.onCompleted: Wifi.scan()
  Component.onDestruction: Wifi.stopScan()
  width: Config.card.wifiExpandedWidth
  height: Config.card.wifiExpandedHeight
  model: Wifi.scannedNetworks
  delegate: Text {
    required property var modelData
    text: modelData.name
    color: Colors.text
  }
}

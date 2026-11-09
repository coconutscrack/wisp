import Quickshell
import QtQuick
import qs.services
import qs.config

ListView {
  id: listView
  spacing: 3
  property real padding: 20
  topMargin: padding
  bottomMargin: padding
  leftMargin: padding
  rightMargin: padding
  Component.onCompleted: Wifi.scan()
  Component.onDestruction: Wifi.stopScan()
  width: Config.card.wifiExpandedWidth
  height: Config.card.wifiExpandedHeight
  model: Wifi.scannedNetworks
  delegate: Rectangle {
    required property var modelData
    height: (listView.height - (padding * 2)) / 10
    Text {
      text: modelData.name
      color: Colors.text
    }
  }
  // Rectangle {
  //   // radius:
  //   anchors.fill: parent
  //   color: Colors.background
  // }
}

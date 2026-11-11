import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.services
import qs.config

ListView {
  id: listView

  model: BluetoothService.discoveredDevices
  property real padding: Config.bluetoothCard.entryHeight / 2

  clip: true

  spacing: 0
  width: Config.bluetoothCard.expandedWidth
  height: (Config.bluetoothCard.numDevicesShown * Config.bluetoothCard.entryHeight)

  Component.onCompleted: {
    BluetoothService.scan()
    listView.forceActiveFocus()
  }
  Component.onDestruction: BluetoothService.stopScan()


  Keys.onPressed: function(event) {
    switch (event.key) {
      case Qt.Key_J:
        listView.incrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_K:
        listView.decrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_Return:
        event.accepted = true
        if (currentItem == null) break
        currentItem.modelData.connected = !currentItem.modelData.connected
        break
    }
  }

  delegate: Rectangle {
    required property var modelData
    radius: Config.card.outerRadius - Config.card.padding
    width: listView.width
    height: listView.height / Config.bluetoothCard.numDevicesShown
    color: ListView.isCurrentItem ? Colors.border : "transparent"
    Text {
      id: deviceIcon
      text: {
        switch (modelData.icon) {
          case "audio-headset":
            return "󰋎"
          case "audio-headphones":
            return "󰋋"
          case "audio-card":
            return "󰓃"
          case "input-keyboard":
            return "󰌌"
          case "input-mouse":
            return "󰍽"
          case "input-gaming":
            return "󰊗"
          case "phone":
            return "󰄜"
          case "computer":
            return "󰌢"
        }
      }
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 18
      verticalAlignment: Text.AlignVCenter
      anchors.verticalCenter: parent.verticalCenter
      leftPadding: listView.padding
    }
    Text {
      id: deviceName
      x: deviceIcon.width
      text: modelData.name
      width: listView.width * (2/3)
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 14
      font.bold: modelData.connected
      verticalAlignment: Text.AlignVCenter
      anchors.verticalCenter: parent.verticalCenter
      leftPadding: listView.padding
      elide: Text.ElideRight
    }
    Text {
      id: deviceInfo
      text: {
        let info = ""
        if (modelData.batteryAvailable) {
          if (modelData.battery <= 1/10)  {
            info += "󰁺"
          } else if (modelData.battery <= 2/10) {
            info += "󰁻"
          } else if (modelData.battery <= 3/10) {
            info += "󰁼"
          } else if (modelData.battery <= 4/10) {
            info += "󰁽"
          } else if (modelData.battery <= 5/10) {
            info += "󰁾"
          } else if (modelData.battery <= 6/10) {
            info += "󰁿"
          } else if (modelData.battery <= 7/10) {
            info += "󰂀"
          } else if (modelData.battery <= 8/10) {
            info += "󰂁"
          } else if (modelData.battery <= 9/10) {
            info += "󰂂"
          } else {
            info += "󰁹"
          }
          
          info += ` ${Math.round(modelData.battery * 100)}% `
        }
        if (modelData.state == BluetoothDeviceState.Connected) info += "󰄬  "
        if (modelData.state == BluetoothDeviceState.Connecting) info += "󰇘  "
        return info.trim()
      }
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 14
      verticalAlignment: Text.AlignVCenter
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      rightPadding: listView.padding
    }
  }
}

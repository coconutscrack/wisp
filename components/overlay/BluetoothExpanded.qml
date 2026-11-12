import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.services
import qs.config

ListView {
  id: listView

  model: ScriptModel {
    id: sModel
    values: {
      if (BluetoothService.discoveredDevices == undefined) return undefined
      return [... BluetoothService.discoveredDevices.values].sort(sectionizeDevices)
    }
  }
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
        if (currentItem == null) return
        if (currentItem.modelData.pairing) {
          currentItem.modelData.cancelPair()
          return
        }
        if (currentItem.modelData.paired) {
          currentItem.modelData.connected = !currentItem.modelData.connected
        } else {
          currentItem.modelData.pair()
        }
        break
      case Qt.Key_X:
        event.accepted = true
        if (currentItem == null) return
        if (currentItem.modelData.paired) {
          currentItem.modelData.forget()
          return
        }
        break
    }
  }

  function sectionizeDevices(a, b) {
    return compareDeviceRank(a, b) ? compareDeviceRank(a, b) : compareDeviceName(a, b)
  }
  function compareDeviceName(a, b) {
    return a.name.localeCompare(b.name)
  }
  function compareDeviceRank(a, b) {
    return deviceRank(a) - deviceRank(b)
  }
  function deviceRank(dev) {
    if (!dev) return null
    if (dev.connected) return 1
    if (dev.paired) return 2
    return 3
  }

  delegate: Column {
  id: itemWrapper
    required property var modelData
    required property int index

    width: listView.width

    Connections {
      target: modelData
      function onPairedChanged() { 
        if (modelData.paired) modelData.connect()
      }
    }
    Rectangle {
      visible: index == 0 || compareDeviceRank(sModel.values[index - 1], modelData)
      width: listView.width
      height: listView.height / Config.bluetoothCard.numDevicesShown
      color: "transparent"
      Text {
        text: { 
          switch (deviceRank(modelData)) {
            case 1: return "Connected"
            case 2: return "Paired"
            case 3: return "Nearby"
          }
        }
        width: listView.width
        color: Colors.textMuted
        font.family: Fonts.text
        font.pixelSize: parent.height / 3
        verticalAlignment: Text.AlignBottom
        anchors.left: parent.left
        anchors.bottomMargin: 5
        anchors.bottom: parent.bottom
        leftPadding: listView.padding
        elide: Text.ElideRight
      }
      Text {
        visible: BluetoothService.isScanning && deviceRank(modelData) == 3
        text: "scanning..."
        color: Colors.textMuted
        font.family: Fonts.text
        font.pixelSize: parent.height / 3
        verticalAlignment: Text.AlignBottom
        anchors.right: parent.right
        anchors.bottomMargin: 5
        anchors.bottom: parent.bottom
        rightPadding: listView.padding
      }
    }

    Rectangle {
      radius: Config.card.outerRadius - Config.card.padding
      width: listView.width
      height: listView.height / Config.bluetoothCard.numDevicesShown
      color: itemWrapper.ListView.isCurrentItem ? Colors.border : "transparent"
      Text {
        id: deviceIcon
        width: listView.width / 10
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
            default: return ""
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
}

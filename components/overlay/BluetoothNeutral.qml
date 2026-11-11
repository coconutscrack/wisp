import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.services
import qs.config

Column {
  spacing: 6
  Text {
    text: {
      switch (BluetoothService.displayStatus) {
        case BluetoothService.Status.NoDevice:
        case BluetoothService.Status.Blocked:
        case BluetoothService.Status.Off:
          return "󰂲"
        case BluetoothService.Status.Connected:
          return "󰂱"
        case BluetoothService.Status.NotConnected:
          return "󰂯"
      }
    }
    color: Colors.text
    font.family: Fonts.icon
    font.pixelSize: 36
    font.bold: false
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
  Text {
    text: "Bluetooth"
    font.family: Fonts.text
    font.pixelSize: 24
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Colors.text
  }
  Text {
    text: {
      switch (BluetoothService.displayStatus) {
        case BluetoothService.Status.NoDevice:
          return "No adapter found"
        case BluetoothService.Status.Blocked:
          return "Adapter blocked"
        case BluetoothService.Status.Off:
          return "Off"
        case BluetoothService.Status.Connected:
          return "Connected"
        case BluetoothService.Status.NotConnected:
          return "Not connected"
      }
    }
    color: Colors.text
    font.family: Fonts.text
    font.pixelSize: 12
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
}

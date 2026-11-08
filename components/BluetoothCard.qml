import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.services
import qs.config

Card {
  neutralComponent: bluetoothNeutral
  expandedComponent: bluetoothExpanded
  quickAction: function() {
    BluetoothService.toggle()
  }
  border.width: 2
  border.color: BluetoothService.enabled ? Colors.border : "transparent"
  Component {
    id: bluetoothNeutral
    BluetoothNeutral {}
  }
  Component {
    id: bluetoothExpanded
    BluetoothExpanded {}
  }
}

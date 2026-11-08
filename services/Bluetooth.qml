pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
  enum Status { NoDeivce, Connected, NotConnected, Off, Blocked }
  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property var connectedDevices: adapter.devices
  readonly property int displayStatus: {
    if (adapter == null) return Bluetooth.Status.NoDevice
    if (adapter.state == BluetoothAdapterState.Blocked) return Bluetooth.Status.Blocked
    if (adapter.state == BluetoothAdapterState.Disabled) return Bluetooth.Status.Off
    if (connectedDevices != undefined) return Bluetooth.Status.Connected
    if (adapter.state == BluetoothAdapterState.Enabled) return Bluetooth.Status.NotConnected
  }

  function toggle() {
    Bluetooth.enabled = !Bluetooth.enabled
  }
}

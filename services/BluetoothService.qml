pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
  enum Status { NoDevice, Connected, NotConnected, Off, Blocked }
  readonly property int displayStatus: {
    if (adapter == null) return BluetoothService.Status.NoDevice
    if (adapter.state == BluetoothAdapterState.Blocked) return BluetoothService.Status.Blocked
    if (connectedDevices.length != 0) return BluetoothService.Status.Connected
    return adapter.state == BluetoothAdapterState.Enabled ? BluetoothService.Status.NotConnected : BluetoothService.Status.Off
  }
  readonly property bool isScanning: adapter?.discovering
  readonly property bool enabled: adapter?.enabled
  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property var discoveredDevices: adapter?.devices
  readonly property var connectedDevices: {
    return discoveredDevices?.values.filter(device => device.connected) ?? []
  }

  function scan() {
    if (adapter) adapter.discovering = true
  }
  function stopScan() {
    if (adapter) adapter.discovering = false
  }
  function toggle() {
    if (adapter) adapter.enabled = !adapter.enabled
  }
}

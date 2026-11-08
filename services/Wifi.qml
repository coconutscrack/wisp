pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
  enum Status { NoDevice, Connected, NotConnected, Off, HardwareDisabled }
  readonly property int displayStatus: {
    if (Wifi.device == null) return Wifi.Status.NoDevice
    if (!Wifi.hardwareEnabled) {
      return Wifi.Status.HardwareDisabled
    } else if (Wifi.enabled) {
      if (Wifi.connectedNetwork != null) {
        return Wifi.Status.Connected
      }
      return Wifi.Status.NotConnected
    } else {
      return Wifi.Status.Off
    }
  }

  readonly property var allDevices: Networking.devices
  readonly property var device: { 
    for (let deviceObject of allDevices.values) {
      if (deviceObject.type == DeviceType.Wifi) {
        return deviceObject
      }
    }
    return null
  }
  readonly property bool hardwareEnabled: Networking.wifiHardwareEnabled
  readonly property bool enabled: Networking.wifiEnabled
  readonly property var scannedNetworks: device?.networks
  readonly property var connectedNetwork: {
    if (scannedNetworks == undefined) return null
    for (let wifiNetwork of scannedNetworks.values) {
      if (wifiNetwork.connected) {
        return wifiNetwork
      }
    }
    return null
  }

  function toggle() {
    Networking.wifiEnabled = !Networking.wifiEnabled
  }
}

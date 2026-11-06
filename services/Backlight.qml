pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import qs.config

Singleton {
  signal brightnessKeyPressed()
  readonly property real brightness: brightnessFile.brightness / maxBrightnessFile.brightness || 0

  function setBrightness(newBrightness) {
    brightnessCommand.newBrightness = newBrightness
    brightnessCommand.running = true
  }

  Process {
    id: brightnessCommand
    property real newBrightness
    running: false
    command: [ "brightnessctl", `-n${Config.brightnessControls.minBrightness}`, "set", `${newBrightness * 100}%` ]
  }

  Process {
    id: backlightDevice
    property string name
    running: true
    command: [ "brightnessctl", "-m" ]
    stdout: StdioCollector {
      onStreamFinished: { 
        const path = this.text.split(",")
        backlightDevice.name = path[0]
      }
    }
  }

  FileView {
    id: brightnessFile
    readonly property real brightness: { parseInt(brightnessFile.text(), 10) }
    path: backlightDevice.name ? "/sys/class/backlight/" + backlightDevice.name + "/brightness" : ""
    watchChanges: true
    onFileChanged: brightnessFile.reload()
  }

  FileView {
    id: maxBrightnessFile
    readonly property real brightness: { parseInt(maxBrightnessFile.text(), 10) }
    path: backlightDevice.name ? "/sys/class/backlight/" + backlightDevice.name + "/max_brightness" : ""
  }

  GlobalShortcut {
    name: "brightness-up"
    onPressed: {
      brightnessKeyPressed()
    }
  }
  GlobalShortcut {
    name: "brightness-down"
    onPressed: {
      brightnessKeyPressed()
    }
  }
}

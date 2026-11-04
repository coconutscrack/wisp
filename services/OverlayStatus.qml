pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  property bool open: false
  GlobalShortcut {
    name: "toggle-overlay"
    onPressed: {
      open = !open
    }
  }
}

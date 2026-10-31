pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  readonly property int wsId: Hyprland.focusedWorkspace == null ?  1 : Hyprland.focusedWorkspace.id
}

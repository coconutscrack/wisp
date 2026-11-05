pragma Singleton

import Quickshell
import QtQuick

Singleton {
  readonly property AnimsConfig anims: AnimsConfig {}
  readonly property FrameConfig frame: FrameConfig {}
  readonly property WorkspacesConfig workspaces: WorkspacesConfig {}
  readonly property ClockConfig clock: ClockConfig {}
  readonly property VolumeControlsConfig volumeControls: VolumeControlsConfig {}
  readonly property BrightnessControlsConfig brightnessControls: BrightnessControlsConfig {}
}

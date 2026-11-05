pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
  signal volumeKeyPressed()
  GlobalShortcut {
    name: "raise-volume"
    onPressed: {
      volumeKeyPressed()
    }
  }
  GlobalShortcut {
    name: "lower-volume"
    onPressed: {
      volumeKeyPressed()
    }
  }
  GlobalShortcut {
    name: "mute"
    onPressed: {
      volumeKeyPressed()
    }
  }

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  readonly property real volume: {
    if (Pipewire.defaultAudioSink == null) return 0
    Pipewire.defaultAudioSink.audio.volume
  }

  function setVolume(volume) {
    if (Pipewire.defaultAudioSink == null) return
    Pipewire.defaultAudioSink.audio.volume = volume
  }

  readonly property bool muted: {
    if (Pipewire.defaultAudioSink == null) return false
    Pipewire.defaultAudioSink.audio.muted
  }

  function toggleMuted() {
    if (Pipewire.defaultAudioSink == null) return
    Pipewire.defaultAudioSink.audio.muted = !muted
  }
}

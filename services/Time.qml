pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  readonly property date date: clock?.date || 0
  readonly property real uptime: bootMoment ? (date - bootMoment) : 0
  readonly property real uptimeHours: { Math.floor(((uptime / 1000) / 60) / 60) }
  readonly property real uptimeMinutes: { Math.floor(((uptime - (uptimeHours * (1000 * 60 * 60))) / 1000) / 60) }
  readonly property real uptimeSeconds: { Math.floor(((uptime - (uptimeHours * (1000 * 60 * 60))) / 1000) - (uptimeMinutes * 1000 * 60) / 1000) }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  property real bootMoment
  FileView {
    id: uptimeFile
    path: "/proc/uptime"
    onLoaded: {
      bootMoment = Date.now() - parseInt(uptimeFile.text().split(" ")[0], 10) * 1000
    }
  }
}

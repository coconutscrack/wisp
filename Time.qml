pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  // id: root
  property date date: clock.date
  //
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
  // Process {
  //   id: dateProc
  //   command: ["date"]
  //   running: true
  //
  //   stdout: StdioCollector {
  //     onStreamFinished: root.time = this.text
  //   }
  // }
  //
  // Timer {
  //   interval: 1000
  //   running: true
  //   repeat: true
  //   onTriggered: dateProc.running = true
  // }
}

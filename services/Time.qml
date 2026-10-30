pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  property date date: clock.date

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

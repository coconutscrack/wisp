pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property date date: clock?.date

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

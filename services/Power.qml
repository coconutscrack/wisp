pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  function lock() {
    lockCmd.running = true
  }
  function suspend() {
    suspendCmd.running = true
  }
  function logout() {
    logoutCmd.running = true
  }
  function reboot() {
    rebootCmd.running = true
  }
  function shutdown() {
    shutDownCmd.running = true
  }

  Process {
    id: lockCmd
    running: false
    command: [ "loginctl", "lock-session" ]
  }
  Process {
    id: suspendCmd
    running: false
    command: [ "systemctl", "suspend" ]
  }
  Process {
    id: logoutCmd
    running: false
    command: [ "exit" ]
  }
  Process {
    id: rebootCmd
    running: false
    command: [ "systemctl", "reboot" ]
  }
  Process {
    id: shutDownCmd
    running: false
    command: [ "systemctl", "poweroff" ]
  }
}

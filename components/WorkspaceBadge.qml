import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Rectangle {
  property string specialName
  property string wsName: {
    if (Hyprland.focusedWorkspace == null) return 0
    return Hyprland.focusedWorkspace.name
  }
  
  visible: !(Hyprland.focusedWorkspace == null)
  implicitWidth: Math.max(nameText.width, nameText.height) + 30
  implicitHeight: nameText.height + 30

  Text {
    id: nameText
    text: specialName || wsName

    anchors.centerIn: parent
    color: "#393934"
    font.bold: false
  }

  Behavior on nameText.implicitWidth {
    NumberAnimation { duration: 200 }
  }

  border.color: "#BEB8AF"
  border.width: 1
  color: "#BFF0EFED"
  radius: height / 2
}

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.config

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
    color: Colors.text
    font.bold: false
  }

  // Behavior on nameText.implicitWidth {
  //   NumberAnimation { duration: 200 }
  // }

  border.color: Colors.border
  border.width: 1
  color: Qt.alpha(Colors.background, Colors.alpha)
  radius: height / 2
}

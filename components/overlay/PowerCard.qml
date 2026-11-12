import Quickshell
import Quickshell.Bluetooth
import QtQuick
import qs.services
import qs.config

Card {
  neutralComponent: powerNeutral
  expandedComponent: powerExpanded
  border.width: 2
  border.color: "transparent"
  Component {
    id: powerNeutral
    PowerNeutral {}
  }
  // Component {
  //   id: powerExpanded
  //   PowerExpanded {}
  // }
}

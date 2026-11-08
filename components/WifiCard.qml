import Quickshell
import QtQuick
import qs.services
import qs.config

Card {
  neutralComponent: wifiNeutral
  expandedComponent: wifiExpanded
  quickAction: function() {
    Wifi.toggle()
  }
  border.width: 2
  border.color: Wifi.enabled ? Colors.border : "transparent"
  Component {
    id: wifiNeutral
    WifiNeutral {}
  }
  Component {
    id: wifiExpanded
    WifiExpanded {}
  }
}

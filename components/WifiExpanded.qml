import Quickshell
import Quickshell.Networking
import QtQuick
import qs.services
import qs.config

ListView {
  id: listView

  model: Wifi.scannedNetworks
  property real padding: Config.wifiCard.entryHeight / 2

  clip: true

  spacing: 0
  width: Config.card.wifiExpandedWidth
  height: (Config.wifiCard.numNetworksShown * Config.wifiCard.entryHeight)

  Component.onCompleted: {
    Wifi.scan()
    listView.forceActiveFocus()
  }
  Component.onDestruction: Wifi.stopScan()


  Keys.onPressed: function(event) {
    switch (event.key) {
      case Qt.Key_J:
        listView.incrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_K:
        listView.decrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_Return:
        if (currentItem != null) {
          if (!currentItem.modelData.connected)
            currentItem.modelData.connect()
          else {
            currentItem.modelData.disconnect()
          }
        } 
        event.accepted = true
        break
    }
  }

  delegate: Rectangle {
    required property var modelData
    radius: Config.card.outerRadius - Config.card.padding
    width: listView.width
    height: listView.height / Config.wifiCard.numNetworksShown
    color: ListView.isCurrentItem ? Colors.border : "transparent"
    Text {
      id: signalStrengthIcon
      text: {
        let icon = "󰢾"
        if (modelData.signalStrength < 1/3) {
          icon = "󰢼"
        } else if (modelData.signalStrength < 2/3) {
          icon = "󰢽"
        }
        return icon
      }
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 18
      verticalAlignment: Text.AlignVCenter
      anchors.verticalCenter: parent.verticalCenter
      leftPadding: listView.padding
    }
    Text {
      id: networkName
      x: signalStrengthIcon.width
      text: modelData.name
      width: listView.width * (2/3)
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 14
      font.bold: modelData.state == ConnectionState.Connected
      verticalAlignment: Text.AlignVCenter
      anchors.verticalCenter: parent.verticalCenter
      leftPadding: listView.padding
      elide: Text.ElideRight
    }
    Text {
      id: networkInfoIcons
      text: {
        let iconString = "";
        if (modelData.state == ConnectionState.Connected) iconString += "󰄬  "
        if (modelData.state == ConnectionState.Connecting) iconString += "󰇘  "
        if (modelData.security != WifiSecurityType.Open) iconString += "󰌾  "
        return iconString.trim()
      }
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 14
      verticalAlignment: Text.AlignVCenter
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      rightPadding: listView.padding
      Behavior on opacity {
        NumberAnimation { 
          easing.type: Config.anims.fadeCurve
          duration: Config.anims.fadeDuration
        }
      }
    }
    // Text {
    //   id: connectionStateIcon
    //   x: listView.width - connectionStateIcon.width - securityIcon.width
    //   text: {
    //     if (modelData.state == ConnectionState.Connected) return "󰄬"
    //     if (modelData.state == ConnectionState.Connecting) return "󰇘"
    //     return " "
    //   }
    //   opacity: modelData.state == ConnectionState.Connected || modelData.state == ConnectionState.Connecting
    //   color: Colors.text
    //   font.family: Fonts.icon
    //   font.pixelSize: 14
    //   anchors.verticalCenter: parent.verticalCenter
    //   rightPadding: listView.padding
    //   Behavior on opacity {
    //     NumberAnimation { 
    //       easing.type: Config.anims.fadeCurve
    //       duration: Config.anims.fadeDuration
    //     }
    //   }
    // }
  }
}

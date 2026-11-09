import Quickshell
import Quickshell.Networking
import QtQuick
import qs.services
import qs.config

ListView {
  id: listView

  model: Wifi.scannedNetworks
  property real padding: Config.wifiCard.entryHeight / 2
  property var pskNetwork

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
        event.accepted = true
        if (currentItem == null) {
          break
        }
        if (currentItem.modelData.connected) {
          currentItem.modelData.disconnect()
          break
        }
        if (currentItem.connectable) {
          currentItem.modelData.connect()
          break
        }
        if (currentItem.requiresPsk) {
          listView.pskNetwork = currentItem.modelData
          break
        }
        break
    }
  }

  delegate: Rectangle {
    required property var modelData
    property bool requiresPsk: modelData.security == WifiSecurityType.WpaPsk || modelData.security == WifiSecurityType.Wpa2Psk
    property bool connectable: modelData.known || modelData.security == WifiSecurityType.Open || modelData.security == WifiSecurityType.Owe

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
      visible: !pskInput.visible
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
    TextInput {
      id: pskInput
      visible: modelData == listView.pskNetwork
      onVisibleChanged: {
        if (visible) forceActiveFocus()
      }
      x: signalStrengthIcon.width
      echoMode: TextInput.Password
      width: listView.width * (2/3)
      color: Colors.text
      font.family: Fonts.icon
      font.pixelSize: 14
      verticalAlignment: Text.AlignVCenter
      anchors.verticalCenter: parent.verticalCenter
      leftPadding: listView.padding
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

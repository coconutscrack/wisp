import Quickshell
import QtQuick
import QtQml.Models
import qs.services
import qs.config

ListView {
  id: listView

  property real padding: Config.powerCard.entryHeight / 2
  property real holdInterval: 0

  NumberAnimation on holdInterval {
    id: fillAnim
    running: false
    from: 0; to: 1; 
    duration: listView.currentItem?.model.confDuration ?? 1500
    onFinished: { 
      Power[listView.currentItem?.model.serviceFunc]() 
      holdInterval = 0
    }
  }

  clip: true
  model: powerModel

  ListModel {
    id: powerModel

    ListElement {
      action: "Lock"
      serviceFunc: "lock"
      confDuration: 500
      icon: "󰌾"
    }
    ListElement {
      action: "Suspend"
      serviceFunc: "suspend"
      confDuration: 500
      icon: "󰽥"
    }
    ListElement {
      action: "Log out"
      serviceFunc: "logout"
      confDuration: 1500
      icon: "󰍃"
    }
    ListElement {
      action: "Reboot"
      serviceFunc: "reboot"
      confDuration: 1500
      icon: "󰜉"
    }
    ListElement {
      action: "Shut down"
      serviceFunc: "shutdown"
      confDuration: 1500
      icon: "󰐥"
    }
  }

  spacing: 0
  width: Config.powerCard.expandedWidth
  height: 6 * Config.powerCard.entryHeight + dividerHeight

  Component.onCompleted: {
    listView.forceActiveFocus()
  }

  Keys.onPressed: function(event) {
    switch (event.key) {
      case Qt.Key_J:
        if (!fillAnim.running) listView.incrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_K:
        if (!fillAnim.running) listView.decrementCurrentIndex()
        event.accepted = true
        break
      case Qt.Key_Return:
        if (!event.isAutoRepeat) fillAnim.restart()
        event.accepted = true
    }
  }
  Keys.onReleased: function(event) {
    if (event.key == Qt.Key_Return && !event.isAutoRepeat) {
        fillAnim.stop()
        holdInterval = 0
        event.accepted = true
    }
  }

  Behavior on holdInterval {
    NumberAnimation { 
      easing.type: Config.anims.powerConfCurve
      duration: Config.anims.powerConfDuration
    }
  }

  readonly property real dividerHeight: Config.powerCard.entryHeight / 2
  delegate: Column {
    id: itemWrapper
    required property var model
    required property int index

    width: listView.width

    Rectangle {
      visible: index == 0 || index == 2
      width: listView.width
      height: {
        if (index == 0) return Config.powerCard.entryHeight
        if (index == 2) return dividerHeight
      }
      color: "transparent"
      Text {
        text: "Session"
        visible: index == 0
        width: listView.width
        color: Colors.textMuted
        font.family: Fonts.text
        font.pixelSize: 14
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: listView.padding
        elide: Text.ElideRight
      }
      Text {
        visible: index == 0
        text: {
          let s = "up"
          if (Time.uptimeHours) s += ` ${Time.uptimeHours}h`
          s += ` ${Time.uptimeMinutes}m`
          s += ` ${Time.uptimeSeconds}s`
          return s
        }
        color: Colors.textMuted
        font.family: Fonts.text
        font.pixelSize: parent.height / 3
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        rightPadding: listView.padding
      }
      Rectangle {
        width: listView.width
        visible: index == 2
        height: 1
        anchors.centerIn: parent
        color: Colors.border
      }
    }

    Rectangle {
      id: selectableRoot
      radius: Config.card.outerRadius - Config.card.padding
      width: listView.width
      height: Config.powerCard.entryHeight
      color: {
        if (itemWrapper.ListView.isCurrentItem) {
          return Colors.border
        } else {
          return "transparent"
        }
      }
      Item {
        width: itemWrapper.ListView.isCurrentItem ? listView.holdInterval * parent.width : 0
        height: parent.height
        anchors.left: parent.left
        clip: true
        Rectangle {
          radius: Config.card.outerRadius - Config.card.padding
          height: selectableRoot.height
          width: selectableRoot.width
          color: Qt.alpha(Colors.critical, 0.5)
        }
      }
      Text {
        id: actionIcon
        width: listView.width / 10
        text: model.icon
        color: {
          if (!itemWrapper.ListView.isCurrentItem) return Colors.text
          if (fillAnim.running) return Colors.critical
          return Colors.text
        }
        Behavior on color {
          ColorAnimation { 
            easing.type: Config.anims.colorCurve
            duration: Config.anims.colorDuration
          }
        }
        font.family: Fonts.icon
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: listView.padding
      }
      Text {
        id: actionText
        x: actionIcon.width
        text: model.action
        width: listView.width * (2/3)
        color: {
          if (!itemWrapper.ListView.isCurrentItem) return Colors.text
          if (fillAnim.running) return Colors.critical
          return Colors.text
        }
        Behavior on color {
          ColorAnimation { 
            easing.type: Config.anims.colorCurve
            duration: Config.anims.colorDuration
          }
        }
        font.family: Fonts.text
        font.pixelSize: 14
        // font.bold: modelData.state == ConnectionState.Connected
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: listView.padding
        elide: Text.ElideRight
      }
      // Text {
      //   id: networkInfoIcons
      //   text: {
      //     let iconString = "";
      //     if (modelData.state == ConnectionState.Connected) iconString += "󰄬  "
      //     if (modelData.state == ConnectionState.Connecting) iconString += "󰇘  "
      //     if (modelData.security != WifiSecurityType.Open) iconString += "󰌾  "
      //     return iconString.trim()
      //   }
      //   color: Colors.text
      //   font.family: Fonts.icon
      //   font.pixelSize: 14
      //   verticalAlignment: Text.AlignVCenter
      //   anchors.right: parent.right
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
}

import QtQuick
import Quickshell
import qs.config

Row {
  property int focusedIdx: 0
  property real focusedIdxForAnim: focusedIdx
  property int count: widgets.length
  readonly property list<Card> widgets: [ wifiCard, bluetoothCard ]
  readonly property Card focusedCard: widgets[focusedIdx]
  function moveFocusTo(cardNum) {
    if (focusedCard.expanded) return
    cardNum = Math.max(cardNum, 0)
    focusedIdx = Math.min(cardNum, count - 1)
  }
  spacing: 48
  anchors.verticalCenter: parent.verticalCenter
  x: ((parent.width / 2) - focusedCard.width / 2) - focusedIdxForAnim * (Config.card.size + spacing)

  Behavior on focusedIdxForAnim {
    NumberAnimation { 
      easing.type: Config.anims.carouselCurve
      duration: Config.anims.carouselDuration
    }
  }


  WifiCard { id: wifiCard }
  BluetoothCard { id: bluetoothCard }
}

import QtQuick
import qs.services
import qs.config

Item {
  id: panel

  readonly property bool hovered: hoverHandler.hovered

  required property string direction
  property bool horizontal: direction == "top" || direction == "bottom"

  required property real openWidth
  required property real openHeight
  property bool openByChange: false
  property bool openByOverlay: OverlayStatus.open
  readonly property bool open: openByChange || openByOverlay

  property real contentWidth: open ? openWidth : 0
  property real contentHeight: open ? openHeight : 0
  property real padding: bumpRadius
  property real bumpHeight: { 
    if (panel.horizontal) {
      return Math.max(contentHeight + padding * 2 - Config.frame.thickness, 0) 
    } else {
      return contentHeight + padding * 2
    }
  }
  property real bumpWidth: {
    if (panel.horizontal) {
      return contentWidth + padding * 2
    } else {
      return Math.max(contentWidth + padding * 2 - Config.frame.thickness, 0)
    }
  }
  property real bumpRadius: { 
    let tmp_r = (contentWidth < contentHeight ? contentWidth / 2 : contentHeight / 2) 
    tmp_r > Config.frame.radius ? Config.frame.radius : tmp_r 
  }
  readonly property real arcRadius: {
    Math.min(bumpRadius, horizontal ? bumpHeight / 2 : bumpWidth / 2)
  }

  anchors {
    top: direction == "top" ? parent.top : undefined
    bottom: direction == "bottom" ? parent.bottom : undefined
    left: direction == "left" ? parent.left : undefined
    right: direction == "right" ? parent.right : undefined
  }
  anchors.horizontalCenter: panel.horizontal ? parent.horizontalCenter : undefined
  anchors.verticalCenter: !panel.horizontal ? parent.verticalCenter : undefined

  width: panel.horizontal ? panel.bumpWidth : Config.frame.thickness + panel.bumpWidth
  height: panel.horizontal ? Config.frame.thickness + panel.bumpHeight : panel.bumpHeight

  Behavior on contentHeight {
    NumberAnimation { 
      easing.type: Config.anims.framePanelCurve
      duration: Config.anims.framePanelDuration
    }
  }

  Behavior on contentWidth {
    NumberAnimation { 
      easing.type: Config.anims.framePanelCurve
      duration: Config.anims.framePanelDuration
    }
  }

  HoverHandler {
    id: hoverHandler
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
  }
}

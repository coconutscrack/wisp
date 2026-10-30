import Quickshell
import QtQuick

Scope {
  Variants {
    model: Quickshell.screens

    Scope {
      required property var modelData

      Spacer {
        screen: modelData
        direction: "top"
      }

      Spacer {
        screen: modelData
        direction: "bottom"
      }

      Spacer {
        screen: modelData
        direction: "left"
      }

      Spacer {
        screen: modelData
        direction: "right"
      }
      Frame {
        screen: modelData
      }
    }
  }
}

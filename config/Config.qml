pragma Singleton

import Quickshell
import QtQuick

Singleton {
  readonly property AnimsConfig anims: AnimsConfig {}
  readonly property FrameConfig frame: FrameConfig {}
  readonly property WorkspacesConfig workspaces: WorkspacesConfig {}
  readonly property BottomPanelConfig bottomPanel: BottomPanelConfig {}
}

# Wisp

A desktop shell for [Hyprland](https://hyprland.org), built with [Quickshell](https://quickshell.org) (QML).

Wisp is a **soft frame**: a thin frame around the whole screen with rounded inner corners. The frame reserves its space, so windows tile inside it. Panels grow out of the frame's edges when they're needed and go back into it afterwards, so the frame looks like it bulges out.

## Two modes

**The clean frame (default).** Every panel is hidden, so the frame is just a clean outline. A panel comes out only when its trigger fires, then goes back:

- **Change-driven**: comes out when something changes. For example, switching workspaces or changing the volume.
- **Threshold-driven**: stays inside the frame until it matters. For example, battery only when it's low.

**The overlay (summoned).** A keybind blurs the screen behind the frame and brings every panel out at once. In the middle sits a **control centre**, like Apple's Control Center: widgets for Wi-Fi, Bluetooth and similar. Each widget expands into a fuller view with a hotkey, and the hotkeys are listed in an expandable hint panel in the bottom-left.

## What works so far

- **Frame**: a frame around the focused monitor, with rounded inner corners and a soft shadow. Four invisible strips reserve its space on each edge. It hides while a window is fullscreen.
- **Workspace panel** (bottom edge): comes out on a workspace switch and closes 2 seconds later. It shows five workspaces with the current one centred, scrolls sideways on a switch, and fades and shrinks the neighbours with their distance.
- **Volume panel** (right edge): comes out when the volume changes, with a mute button and a draggable slider. It stays open while you drag.
- **Clock panel** (top edge): the date and time. It comes out only with the overlay.
- **Overlay**: Super+Comma blurs and tints the screen behind the frame, and every panel comes out with it. Hyprland fades it in and out, blur included. It also appears over fullscreen windows (the frame stays hidden then).

Every bump rises out of the frame with arcs, sized from what it holds, and animates open and closed.

## Planned

- A **brightness panel** on the left edge, like the volume panel.
- **Special workspaces**: the workspace panel shows the special workspace's name instead of the row.
- Closing the overlay with Escape, and keyboard input while it's open.
- The **control centre**: Wi-Fi and Bluetooth widgets first, then more. Each expands with a hotkey.
- The **hint panel** listing the overlay's hotkeys.
- Possibly more frame panels later: low battery, network only on disconnect, now playing, notifications.

## Requirements

- Hyprland
- Quickshell

### Hyprland setup

- **Blur:** the overlay window uses the layer namespace `wisp-overlay`. Add a layer rule matching it that enables blur, with `ignore_alpha` so only painted pixels are blurred. The frame uses the namespace `qs` and needs no rule; it isn't meant to be blurred.
- **Fade:** set Hyprland's layer animations to the `fade` style, so the overlay fades in and out.
- **Overlay key:** bind a key with the `global` dispatcher to `quickshell:toggle-overlay` (Wisp uses Super+Comma).
- Set `gaps_out` so windows leave a gap inside the frame, and window rounding to match the frame's inner corners (30).

## Running

`~/.config/quickshell/` may hold an older copy of Wisp, so start Quickshell pointing at this project: `qs -c` followed by the path to this folder. `qs log -c` with the same path shows the log.

## Files

- `shell.qml`: entry point.
- `surfaces/`: windows and their triggers.
  - `ShellWrapper.qml`: for each monitor, the strips, the overlay window and the frame window, plus whether the monitor is focused and has a fullscreen window.
  - `Spacer.qml`: an invisible strip that reserves one edge.
  - `Overlay.qml`: the overlay's blurred, full-screen window.
  - `Frame.qml`: the window that draws the frame and its panels.
- `components/`: visuals with no window: `WorkspaceRow`, `Clock`, `Volume`, `VolumeIcon`, `VolumeSlider`.
- `services/`: data with no visuals: `Time`, `FocusedWorkspace`, `Audio`, `OverlayStatus` (which also holds the overlay's shortcut).
- `config/`: `Colors` (the palette by role), `Fonts`, and `Config` with one group per feature.
- `legacy/`: the old workspace indicator and clock, kept for reference and not loaded.

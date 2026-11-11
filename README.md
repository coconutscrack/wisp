# Wisp

A desktop shell for [Hyprland](https://hyprland.org), built with [Quickshell](https://quickshell.org) (QML).

Wisp is a **soft frame**: a thin frame around the whole screen with rounded inner corners. The frame reserves its space, so windows tile inside it. Panels grow out of the frame's edges when they're needed and go back into it afterwards, so the frame looks like it bulges out.

## Two modes

**The clean frame (default).** Every panel is hidden, so the frame is just a clean outline. A panel comes out only when its trigger fires, then goes back:

- **Change-driven**: comes out when something changes. For example, switching workspaces or changing the volume.
- **Threshold-driven**: stays inside the frame until it matters. For example, battery only when it's low.

**The overlay (summoned).** A keybind blurs the screen behind the frame and brings every panel out at once. In the middle sits a **control centre**: a row of cards for Wi-Fi, Bluetooth and similar. Each card has a quick action and expands into a fuller view, all from the keyboard.

## What works so far

### The frame

- **Frame**: a frame around the focused monitor, with rounded inner corners and a soft shadow. Four invisible strips reserve its space on each edge. It hides while a window is fullscreen, unless a panel is open.
- **Workspace panel** (bottom edge): comes out on a workspace switch and closes 2 seconds later. It shows five of the ten workspaces with the current one centred, scrolls sideways on a switch, and fades and shrinks the neighbours with their distance.
- **Volume panel** (right edge): comes out when a volume key is pressed, with a mute button and a draggable slider.
- **Brightness panel** (left edge): comes out when a brightness key is pressed, with a draggable slider. It finds the backlight device on its own and never goes below a minimum brightness.
- The volume and brightness panels stay open while you drag the slider or hover over them, and close 2 seconds after you leave.
- **Clock panel** (top edge): the date and time. It comes out only with the overlay.

Every bump rises out of the frame with arcs, sized from what it holds, and animates open and closed.

### The overlay

Super+Comma blurs and tints the screen behind the frame, and every panel comes out with it. Hyprland fades it in and out, blur included. It also appears over fullscreen windows, and it closes on its own when you switch workspaces.

The overlay takes the keyboard while it's open. The control centre is a carousel of cards that slides to keep the focused card in the middle:

- **Wi-Fi card**: an icon for the signal strength and the connected network's name. Its quick action turns Wi-Fi on or off. Expanded, it scans and lists nearby networks with their signal, security and connection state. Choosing a network connects to it, or disconnects if it's already connected. A WPA/WPA2 Personal network you haven't joined before asks for its password inline.
- **Bluetooth card**: an icon and whether a device is connected. Its quick action turns Bluetooth on or off. Expanded, it scans and lists devices with an icon for their type, their battery level when known, and their connection state. Choosing a device connects or disconnects it.

| Key | Card row | Expanded card |
| --- | --- | --- |
| `H` / `L` | Focus the previous / next card | |
| `J` / `K` | | Move down / up the list |
| `Space` | Run the focused card's quick action | |
| `Enter` | Expand the focused card | Connect / disconnect the selected entry |
| `Esc` | Close the overlay | Collapse the card (or cancel the password prompt) |

## Planned

- **Special workspaces**: the workspace panel shows the special workspace's name instead of the row.
- More control centre cards.
- The **hint panel** in the bottom-left, listing the overlay's hotkeys.
- A **settings widget** backed by a plain data file, so settings can change at runtime and Hyprland can read the ones it shares (the brightness minimum first).
- Possibly more frame panels later: low battery, network only on disconnect, now playing, notifications.

## Requirements

- Hyprland
- Quickshell
- PipeWire (volume)
- `brightnessctl` (brightness)
- NetworkManager (Wi-Fi)
- BlueZ (Bluetooth)
- The fonts JetBrains Mono and JetBrainsMono Nerd Font Propo

### Hyprland setup

- **Blur:** the overlay window uses the layer namespace `wisp-overlay`. Add a layer rule matching it that enables blur, with `ignore_alpha` so only painted pixels are blurred. The frame uses the namespace `qs` and needs no rule; it isn't meant to be blurred.
- **Fade:** set Hyprland's layer animations to the `fade` style, so the overlay fades in and out.
- **Overlay key:** bind a key with the `global` dispatcher to `quickshell:toggle-overlay` (Wisp uses Super+Comma).
- **Volume and brightness keys:** Hyprland changes the volume and brightness itself, so the keys keep working even when Quickshell isn't running. To make the panels come out too, also bind each key with the `global` dispatcher:
  - `quickshell:raise-volume`, `quickshell:lower-volume` and `quickshell:mute`
  - `quickshell:brightness-up` and `quickshell:brightness-down`
- **Brightness minimum:** Wisp's minimum lives in `config/BrightnessControlsConfig.qml` (`minBrightness`). Pass the same value to `brightnessctl -n` in your Hyprland brightness binds, and keep the two in sync by hand for now.
- Set `gaps_out` so windows leave a gap inside the frame, and window rounding to match the frame's inner corners (30).

## Running

`~/.config/quickshell/` may hold an older copy of Wisp, so start Quickshell pointing at this project: `qs -c` followed by the path to this folder. `qs log -c` with the same path shows the log.

## Files

- `shell.qml`: entry point.
- `surfaces/`: windows and their triggers.
  - `ShellWrapper.qml`: for each monitor, the strips, the overlay window and the frame window, plus whether the monitor is focused and has a fullscreen window.
  - `Spacer.qml`: an invisible strip that reserves one edge.
  - `Overlay.qml`: the overlay's blurred, full-screen window, its keyboard handling and the carousel.
  - `Frame.qml`: the window that draws the frame and its four panels, and when each opens and closes.
- `components/`: visuals with no window.
  - Frame: `FrameInnerEdge` (the frame's shape), `FramePanel` (one bump on an edge), `WorkspaceRow`, `Clock`, `Volume`, `VolumeIcon`, `VolumeSlider`, `Brightness`, `BrightnessIcon`, `BrightnessSlider`.
  - Control centre: `Carousel`, `Card` (the base for every card: size, shadow, quick action and expanding), and each card split into its card, neutral view and expanded view: `WifiCard`, `WifiNeutral`, `WifiExpanded`, `BluetoothCard`, `BluetoothNeutral`, `BluetoothExpanded`.
- `services/`: data with no visuals: `Time`, `FocusedWorkspace`, `Audio`, `Backlight`, `Wifi`, `BluetoothService`, `OverlayStatus` (which also holds the overlay's shortcut).
- `config/`: `Colors` (the palette by role), `Colors1` (a light palette, not loaded), `Fonts`, and `Config` with one group per feature (`AnimsConfig`, `FrameConfig`, `WorkspacesConfig`, `ClockConfig`, `VolumeControlsConfig`, `BrightnessControlsConfig`, `CardConfig`, `WifiCardConfig`, `BluetoothCardConfig`).
- `legacy/`: the old workspace indicator and clock, kept for reference and not loaded.

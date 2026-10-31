# Wisp

A desktop shell for [Hyprland](https://hyprland.org), built with [Quickshell](https://quickshell.org) (QML).

Wisp is a **soft frame**: a thin, warm frame around the whole screen with rounded inner corners. The frame reserves its space, so windows tile inside it. Panels grow out of the frame's edges when they're needed and go back into it afterwards, so the frame looks like it bulges out.

## How panels appear

The frame is always there. Everything else comes out of it, and each panel has one trigger:

- **Change-driven**: comes out when something changes, then goes back. For example, switching workspaces.
- **Threshold-driven**: stays inside the frame until it matters. For example, battery only when it's low.
- **Summoned**: comes out only when asked for. For example, clicking a panel's bump.

Each panel has a small bump in the frame where it lives, which is always visible. The bump grows slightly on hover and opens fully into the panel when clicked or when the panel's own trigger fires.

## What works so far

### Frame

- A translucent sepia frame around every monitor, with rounded inner corners, blurred by Hyprland.
- Four invisible strips reserve the frame's space on each edge, so windows tile inside it.
- One full-screen window draws the frame and all panels. Clicks pass through it everywhere except the bumps.

### Workspace panel (bottom edge, centre)

- A bump in the middle of the bottom edge, drawn with Bézier curves, so it rises smoothly out of the frame.
- Three states, animated between each other: neutral (a small handle), hover (slightly bigger) and open.
- Clicking the bump opens it. Moving the pointer away closes it.
- When open, it shows a row of workspaces 1–10 with the current one in the centre. At the ends, the empty slots stay blank.
- Switching workspace scrolls the row sideways until the new workspace is centred.
- The row is revealed as the bump grows, and fades in and out with it.

### Old workspace indicator

The indicator from before the soft-frame design still runs until the workspace panel replaces it: a badge in the bottom-left corner showing the current workspace's number, or the name of a special workspace. It hides 2 seconds after the last switch.

## Next

1. **Workspace service**: a singleton in `services/` that gives the current workspace as a plain number, with a null guard so nothing breaks before Hyprland has reported a workspace (for example at startup).
2. **Config refactor**: move the scattered numbers into config. Separate the numbers you choose from the ones calculated from them, starting with whether the slot width comes from the open plateau width or the other way round. Timings (`InOutQuad`, 150ms, now repeated three times) get their own singleton.
3. **Open on workspace switch**: open the bottom panel when the workspace changes and close it again with a `Timer`, so the row's scroll is visible.

## Planned

- **Special workspaces**: the workspace panel shows the special workspace's name instead of the row.
- **Fullscreen**: the frame hides while a window is fullscreen.
- **More panels**, for example volume and brightness while they change, low battery, network only on disconnect, now playing, notifications, a clock and calendar, and a launcher.

## Requirements

- Hyprland
- Quickshell

### Hyprland setup

- All of Wisp's windows use the layer namespace `qs`. Add a layer rule for it that enables blur with `ignore_alpha`, so only the frame and panels are blurred and not the frame window's transparent middle.
- Set `gaps_out` so windows leave a gap inside the frame.
- Set window rounding to match the frame's inner corners (30).

## Running

`~/.config/quickshell/` may hold an older copy of Wisp, so start Quickshell pointing at this project:

```sh
quickshell -p /path/to/wisp
```

## Files

- `shell.qml`: entry point. Creates the frame and the old workspace indicator.
- `surfaces/`: windows, with their anchoring, masks and triggers.
  - `FrameWrapper.qml`: one set of strips and one frame per monitor.
  - `Spacer.qml`: an invisible strip that reserves one edge.
  - `Frame.qml`: the full-screen window that draws the frame and the panels.
  - `WorkspaceIndicator.qml`: the old workspace indicator.
- `components/`: visuals with no window. `WorkspaceBadge.qml` is the old indicator's badge.
- `config/`: look and feel. `Colors.qml` holds the palette by role and `Sizes.qml` the frame's sizes.
- `services/`: data with no visuals. `Time.qml` provides the current time.
- `ClockWidget.qml`, `WorkspaceWidget.qml`: leftovers from before the soft frame, not loaded.

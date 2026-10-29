# Wisp

A minimal desktop shell for [Hyprland](https://hyprland.org), built with [Quickshell](https://quickshell.org) (QML).

Wisp is about screen space. There's no always-visible bar: every piece of UI stays hidden until it's needed, then fades away again, and nothing reserves space on screen or pushes windows around.

## How UI appears

Each piece of information has one trigger:

- **Change-driven**: appears when something changes, then fades. For example, switching workspaces.
- **Threshold-driven**: hidden until it matters. For example, battery only when it's low.
- **Summoned**: appears only when asked for. For example, an overlay opened with a keybind.

## What works so far

### Workspace popup

Switch workspace and a pill fades in at the bottom centre of the screen, then fades out 3 seconds after your last switch.

- Shows workspaces 1–10, with the focused one highlighted.
- Floats above all windows with no exclusive zone, so it never takes up screen space.
- Sizes itself from its content instead of stretching along a screen edge.
- Has a frosted-glass background blur, inset just inside the border so the blur's edge stays hidden under it.
- Is created on every monitor.
- Fading is done by Hyprland's layer animations, so the pill and its blur fade together. Wisp only shows and hides the window.

### Clock

A shared `Time` singleton provides the current time, and a basic clock widget formats it. It isn't shown on any surface yet.

## Planned

- **Workspace indicator**: the bottom popup changes to show only the current workspace: a circle with its number, or a pill with the name for special workspaces.
- **Overlay (centre)**: summoned with a keybind. Holds the full workspace bar, a clock and other widgets.
- **Status circle (top right)**: appears only for alerts such as low battery or an active screen recording.

## Requirements

- Hyprland
- Quickshell

### Hyprland setup

Wisp's windows use the layer namespace `qs`. For the fade to work:

- Layer fade animations (`fadeLayersIn` / `fadeLayersOut`) must be enabled in your Hyprland config. Their speed controls how long Wisp takes to fade.
- No layer rule may disable animations (`no_anim`) for the `qs` namespace.

## Files

- `shell.qml`: entry point, creates the surfaces.
- `WorkspaceWidget.qml`: the workspace popup.
- `Time.qml`: shared clock singleton.
- `ClockWidget.qml`: simple time display.
- `Bar.qml`: early full-width bar, no longer used.

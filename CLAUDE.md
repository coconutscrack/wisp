# wisp

Quickshell/QML shell for Hyprland. The user writes all code to learn Qt/QML.
Guide with questions and pointers only; don't edit their QML.

## Current status (2026-10-31)

### Done: Hyprland blur for layer surfaces
- Blur moved from `BackgroundEffect.blurRegion` to Hyprland layer rules
  (`~/.config/hypr/vesper/windowrules.lua`, matching namespace `qs`).
- Rule uses `blur`, `ignore_alpha` (blur only painted pixels, not the
  full-screen transparent Frame), `xray` (sample wallpaper only, so dark windows
  don't dim it), and `no_anim`.
- Global blur enabled in `vesper/decorations.lua`, with `passes` lowered.
  Blur reach is roughly `size * 2^passes`.
- Every shell window must use a namespace the rule matches. The
  `WorkspaceIndicator` used `wisp-pop-in` and so missed the rule. Consider
  making the rule `match` a regex.

### Next: popout panel (part of Frame's surface)
Decisions so far:
- The popout is just a bigger bottom bump: an "open" state with large
  `bumpHeight` / `bumpBaseWidth` / `bumpPlateauWidth` in `surfaces/Frame.qml`.
  Later bumps may cover about 1/4 of the screen.
- Open is triggered by a click. The hovered state becomes `when: hovered && !open`.
- Contents: a scrollable workspace panel.
- Same namespace and look as everything else.

Open questions to work through:
1. At big sizes, does the flat plateau `PathLine` still look right, or does
   it need rounded top corners (`PathArc`)? Consider `Shape.preferredRendererType`
   (`CurveRenderer`) only if the animation stutters. Think about making bumps
   reusable (other edges, several at once).
2. Content positioning: make the panel a child of `bottomPanel`, which already
   follows the bump? Its width should follow the plateau, not `bumpBaseWidth`.
   Use `clip: true` during animation.
3. Where does the `open` boolean live (a property), and what flips it
   (`TapHandler`)? How does it close, given that the mask makes clicks outside
   go through to windows?
4. Mask is `Region { item: bottomPanel }`. If `bottomPanel` grows, the mask
   may just follow. Scrolling: `Flickable` vs `ListView`.

Suggested starting point: add an "open" state with large values and see how
the existing curve copes.

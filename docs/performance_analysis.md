# Performance Analysis Walkthrough

## Scope reviewed
- Home screen async rendering and animations.
- History weekly list rendering behavior.
- Shared cards (`Shortcut`, promo card, text animation).
- Network flow (`getAllFuels`, `getHistory`).

## Findings

### 1) Repeated network calls risk
`FutureBuilder` creates futures in build methods (`getAll`, `getHistory`).
- **Risk:** Each rebuild may trigger requests.
- **Recommendation:** Cache the future in `initState` per screen.

### 2) Heavy widgets in long lists
History uses `ExpansionTile` + nested `GridView`.
- **Current mitigation:** `shrinkWrap + NeverScrollableScrollPhysics` avoids nested scroll conflicts.
- **Risk:** Large history can still increase build cost.
- **Recommendation:** keep item count bounded or paginate older weeks.

### 3) Animations
- `TweenAnimationBuilder` and `AnimatedContainer` are lightweight and appropriate for current UI.
- **Recommendation:** Avoid adding many simultaneous implicit animations in list items.

### 4) SVG usage
- SVGs improve visual clarity and bundle flexibility.
- **Risk:** Very complex SVG paths can cost rasterization time.
- **Recommendation:** Keep assets simple (current assets are minimal).

## Practical checklist (to run locally)
1. `flutter run --profile`
2. Open DevTools timeline and inspect frame build/raster times.
3. Scroll full history list and confirm frame budget under 16ms on target device.
4. Validate memory while expanding/collapsing several weeks.

## Target goals
- Build frame: < 16ms average on mid-range Android.
- No duplicated network request per simple state update.
- Smooth transitions during navigation and list expansion.

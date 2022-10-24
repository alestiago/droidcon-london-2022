import 'package:flame/components.dart';
import 'package:flame/input.dart';

/// Propagates [Tappable] events to all [Tappable] children.
mixin TappablePropagator on Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    final tappables = children.whereType<Tappable>();
    for (final tappable in tappables) {
      tappable.onTapDown(info);
    }
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    final tappables = children.whereType<Tappable>();
    for (final tappable in tappables) {
      tappable.onTapUp(info);
    }
    return true;
  }

  @override
  bool onTapCancel() {
    final tappables = children.whereType<Tappable>();
    for (final tappable in tappables) {
      tappable.onTapCancel();
    }
    return true;
  }
}

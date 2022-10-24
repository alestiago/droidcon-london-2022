import 'package:flutter/material.dart';

class ImplicitAnimatedValue<T> {
  ImplicitAnimatedValue({
    required this.vsync,
    this.duration = const Duration(seconds: 1),
    Tween<T>? tween,
  }) {
    _currentTween = tween ?? Tween<T>();
    _currentTween.begin ??= _currentTween.end;

    if (_currentTween.begin != _currentTween.end) {
      _controller.forward();
    }
  }

  late Tween<T> _currentTween;

  final TickerProvider vsync;
  final Duration duration;

  late final AnimationController _controller = AnimationController(
    vsync: vsync,
    duration: duration,
  );

  T? _lastTargetedValue;

  T forTarget(T targetValue) {
    _currentTween.begin ??= targetValue;
    _currentTween.end ??= targetValue;
    final value = _currentTween.evaluate(_controller);

    if (_lastTargetedValue != targetValue) {
      _lastTargetedValue = targetValue;
      if (value != targetValue) {
        _currentTween
          ..begin = value
          ..end = targetValue;

        _controller.forward(from: 0);
      }
    }
    return value;
  }

  void dispose() {
    _controller.dispose();
  }
}

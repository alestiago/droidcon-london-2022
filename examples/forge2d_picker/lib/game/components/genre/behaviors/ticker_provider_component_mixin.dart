import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Provides [Ticker] objects that are configured to only tick while 
/// the component is mounted
///
/// To create an [AnimationController] in a class that uses this mixin, pass
/// `vsync: this` to the animation controller constructor whenever you
/// create a new animation controller.
@optionalTypeArgs
mixin TickerProviderComponentMixin on Component implements TickerProvider {
  Set<Ticker>? _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_ComponentTicker>{};
    final result = _ComponentTicker(
      onTick,
      this,
      debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null,
    );

    _tickers!.add(result);
    return result;
  }

  void _removeTicker(_ComponentTicker ticker) {
    assert(_tickers != null, '_tickers shouldn`t be null when removing a tick');
    assert(
      _tickers!.contains(ticker),
      '_tickers should contain ticker that is going to be removed',
    );
    _tickers!.remove(ticker);
  }

  @override
  void onMount() {
    if (_tickers != null) {
      for (final ticker in _tickers!) {
        ticker.muted = false;
      }
    }
    super.onMount();
  }

  @override
  void onRemove() {
    if (_tickers != null) {
      for (final ticker in _tickers!) {
        ticker.muted = true;
      }
    }
    super.onRemove();
  }
}

class _ComponentTicker extends Ticker {
  _ComponentTicker(super.onTick, this._creator, {super.debugLabel});

  final TickerProviderComponentMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}

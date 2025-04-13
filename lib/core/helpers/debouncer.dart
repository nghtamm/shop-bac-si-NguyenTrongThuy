import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

  Future<T> asynchronousDebounce<T>(Future<T> Function() callback) {
    _timer?.cancel();
    final completer = Completer<T>();
    _timer = Timer(delay, () async {
      try {
        final result = await callback();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      }
    });
    return completer.future;
  }
}

import 'package:flutter/foundation.dart';

import 'watchable_change_action.dart';
import 'watchable_change_result.dart';

@protected
class WatchHandler {
  static Map<String, dynamic> _watcher = {};

  /// Register new Watcher
  static registerWatcher(dynamic watcher) {
    _watcher[watcher.watcherId] = watcher;
  }

  /// Trigger Watcher with `watcherId`
  static Future<WatchableChangeResult> trigger(String watcherId,
      WatchableChangeAction watchableChangeAction, dynamic data) async {
    if (!_watcher.containsKey(watcherId)) {
      return WatchableChangeResult.error();
    }
    return await _watcher[watcherId].trigger(watchableChangeAction, data);
  }
}

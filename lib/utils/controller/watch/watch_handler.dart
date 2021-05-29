import 'package:flutter/foundation.dart';

import 'watchable_change_action.dart';
import 'watchable_change_result.dart';

@protected
class WatchHandler {
  static Map<String, dynamic> watcher = {};

  /// Register new Watcher
  static registerWatcher(dynamic watcher) {
    watcher[watcher.watcherId] = watcher;
  }

  /// Trigger Watcher with `watcherId`
  static Future<WatchableChangeResult> trigger(String watcherId,
      WatchableChangeAction watchableChangeAction, dynamic data) async {
    if (!watcher.containsKey(watcherId)) {
      return WatchableChangeResult.error();
    }
    return await watcher[watcherId].trigger(watchableChangeAction, data);
  }
}

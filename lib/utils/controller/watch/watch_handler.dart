import 'package:flutter/foundation.dart';

import 'watchable_change_action.dart';

@protected
class WatchHandler {
  static Map<String, dynamic> watcher = {};
  static registerWatcher(dynamic watcher) {
    watcher[watcher.getId()] = watcher;
  }

  static trigger(String watcherId, WatchableChangeAction watchableChangeAction,
      dynamic data) {
    if (!watcher.containsKey(watcherId)) {
      return;
    }
    watcher[watcherId].trigger(watchableChangeAction, data);
  }
}

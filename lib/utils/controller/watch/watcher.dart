import 'package:twipe_flutter_core/utils/controller/watch/watch_handler.dart';

import 'watchable_change_action.dart';
import 'watchable_change_result.dart';

abstract class Watcher {
  String get watcherId;

  Watcher() {
    WatchHandler.registerWatcher(this);
  }

  /// Trigger Watcher
  Future<WatchableChangeResult> trigger(
      WatchableChangeAction watchableChangeAction, dynamic data) async {
    return await onTrigger(watchableChangeAction, data);
  }

  /// On Watcher was triggered
  Future<WatchableChangeResult> onTrigger(
          WatchableChangeAction watchableChangeAction, dynamic data) =>
      throw UnimplementedError();
}

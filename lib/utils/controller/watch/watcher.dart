import 'package:twipe_flutter_core/utils/controller/watch/watch_handler.dart';

import 'watchable_change_action.dart';

abstract class Watcher {
  String get id => throw UnimplementedError();
  Watcher() {
    WatchHandler.registerWatcher(this);
  }
  String getId() {
    return id;
  }

  trigger(WatchableChangeAction watchableChangeAction, dynamic data) {
    onTrigger(watchableChangeAction, data);
  }

  onTrigger(WatchableChangeAction watchableChangeAction, dynamic data) =>
      throw UnimplementedError();
}

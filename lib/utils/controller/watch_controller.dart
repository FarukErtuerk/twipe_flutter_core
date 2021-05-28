import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watcher.dart';

import 'watch/watch_handler.dart';

abstract class WatchController implements Watcher {
  WatchController() {
    WatchHandler.registerWatcher(this);
  }
  @override
  Future<WatchableChangeResult> trigger(
      WatchableChangeAction watchableChangeAction, data) async {
    return await onTrigger(watchableChangeAction, data);
  }
}

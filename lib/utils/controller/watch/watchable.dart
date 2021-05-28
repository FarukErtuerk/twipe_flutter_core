import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watch_handler.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';

import 'watchable_change_result.dart';

mixin Watchable {
  @protected
  String get watcherId;
  @protected
  String get watchableId;

  /// Trigger Watcher
  Future<WatchableChangeResult> change({dynamic data}) async {
    dynamic _onChangeData = await onChange();
    WatchableChangeAction action = WatchableChangeAction(watchableId, data);
    return WatchHandler.trigger(watcherId, action, _onChangeData);
  }

  /// On Watchable change
  Future<dynamic> onChange() => throw UnimplementedError();
}

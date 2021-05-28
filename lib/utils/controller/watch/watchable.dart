import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watch_handler.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';

import 'watchable_change_result.dart';

mixin Watchable {
  @protected
  String get watcherId;
  @protected
  String get watchableId;

  Future<WatchableChangeResult> change({dynamic eventData}) async {
    dynamic data = await onChange();
    WatchableChangeAction action =
        WatchableChangeAction(watchableId, eventData);
    return WatchHandler.trigger(watcherId, action, data);
  }

  Future<dynamic> onChange() => throw UnimplementedError();
}

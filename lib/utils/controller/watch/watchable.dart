import 'package:twipe_flutter_core/utils/controller/watch/watch_handler.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';

mixin Watchable {
  String get watcherId => throw UnimplementedError();
  String get watchableId => throw UnimplementedError();
  change({dynamic eventData}) {
    dynamic data = onChange();
    WatchableChangeAction action =
        WatchableChangeAction(watchableId, eventData);
    WatchHandler.trigger(watcherId, action, data);
  }

  dynamic onChange() => throw UnimplementedError();
}

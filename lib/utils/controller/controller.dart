import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';
import 'package:twipe_flutter_core/utils/controller/watch_controller.dart';
import 'package:twipe_flutter_core/utils/eloquent/collection/collection.dart';
import 'package:twipe_flutter_core/utils/eloquent/model/model.dart';
import 'watch/watch_handler.dart';

/* Controller<T> with Collection<T> and WatchController */
abstract class Controller<T extends Model> extends Collection<T>
    implements WatchController {
  Controller(String id) : super(id) {
    WatchHandler.registerWatcher(this);
  }

  @override
  String get watcherId => getId();

  @override
  Future<WatchableChangeResult> trigger(
      WatchableChangeAction watchableChangeAction, data) async {
    return await onTrigger(watchableChangeAction, data);
  }
}

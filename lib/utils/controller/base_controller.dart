import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';
import 'package:twipe_flutter_core/utils/controller/watch_controller.dart';
import 'package:twipe_flutter_core/utils/eloquent/collection/collection.dart';
import 'package:twipe_flutter_core/utils/eloquent/model/model.dart';
import 'watch/watch_handler.dart';

/* BaseController<T> with Collection<T> and WatchController */
abstract class BaseController<T extends Model> extends Collection<T>
    implements WatchController {
  BaseController(String id) : super(id) {
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

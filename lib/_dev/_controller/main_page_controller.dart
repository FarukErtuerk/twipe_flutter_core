import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_action.dart';
import 'package:twipe_flutter_core/utils/controller/watch_controller.dart';

class MainPageController extends WatchController {
  @override
  Future<WatchableChangeResult> onTrigger(
      WatchableChangeAction watchableChangeAction, data) async {
    return WatchableChangeResult.done();
  }

  @override
  String get watcherId => "main_page_watcher";
}

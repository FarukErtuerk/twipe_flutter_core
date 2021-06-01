import 'package:twipe_flutter_core/utils/controller/base_controller.dart';
import 'package:twipe_flutter_core/utils/controller/collection_controller.dart';
import 'package:twipe_flutter_core/utils/controller/watch_controller.dart';

class ControllerManager {
  static Map<String, dynamic> _collectionController = {};
  static Map<String, dynamic> _watchController = {};
  static Map<String, dynamic> _baseController = {};
  static Future<void>
      registerCollectionController<T extends CollectionController>(
          T controller) async {
    await controller.setup();
    _collectionController[controller.getId()] = controller;
  }

  static Future<void> registerBaseController<T extends BaseController>(
      T controller) async {
    await controller.setup();
    _collectionController[controller.getId()] = controller;
  }

  static Future<void> registerWatchController<T extends WatchController>(
      T controller) async {
    _collectionController[controller.watcherId] = controller;
  }

  static void unregisterCollectionController(String controllerId) {
    if (_collectionController.containsKey(controllerId)) {
      _collectionController.remove(controllerId);
    }
  }

  static void unregisterBaseController(String controllerId) {
    if (_baseController.containsKey(controllerId)) {
      _baseController.remove(controllerId);
    }
  }

  static void unregisterWatchController(String controllerId) {
    if (_watchController.containsKey(controllerId)) {
      _watchController.remove(controllerId);
    }
  }

  static T getCollectionController<T extends CollectionController>(
      String controllerId) {
    return _collectionController[controllerId] as T;
  }

  static T getBaseController<T extends BaseController>(String controllerId) {
    return _baseController[controllerId] as T;
  }

  static T getWatchController<T extends WatchController>(String controllerId) {
    return _watchController[controllerId] as T;
  }
}

import 'package:twipe_flutter_core/cache/cache_handler.dart';
import 'package:twipe_flutter_core/cache/cache_object.dart';
import 'package:twipe_flutter_core/utils/eloquent/model/model.dart';

class NetworkFakerDatabase {
  final String _id;
  NetworkFakerDatabase(this._id);

  String getId() {
    return _id;
  }

  Future<void> clear() async {
    await CacheHandler.removeCacheObject("network_faker_database_" + _id);
  }

  Future<bool> saveModel(Model model) async {
    if (!model.validate()) {
      return false;
    }
    return await CacheHandler.saveCacheObjectToList(
        "network_faker_database_" + _id, model.toCacheObject(), "id");
  }

  Future<List<CacheObject>> getAll() async {
    return await CacheHandler.getCacheList("network_faker_database_" + _id);
  }

  Future<CacheObject?> getModel(String id) async {
    CacheObject? cacheObject = await CacheHandler.getCacheObjectFromList(
        "network_faker_database_" + _id, "id", id);
    if (cacheObject == null) {
      return null;
    }
    return cacheObject;
  }
}

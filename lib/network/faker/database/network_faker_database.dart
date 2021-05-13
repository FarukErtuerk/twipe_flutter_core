import 'package:twipe_flutter_core/cache/cache_handler.dart';
import 'package:twipe_flutter_core/cache/cache_object.dart';
import 'package:twipe_flutter_core/model/cached_model.dart';
import 'package:twipe_flutter_core/model/model.dart';

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

  Future<Map<String, CachedModel>> getAll() async {
    List<CacheObject> cache =
        await CacheHandler.getCacheList("network_faker_database_" + _id);
    Map<String, CachedModel> result = {};
    for (CacheObject cacheObject in cache) {
      CachedModel cachedModel = CachedModel(cacheObject.data);
      result[cachedModel.getId()] = cachedModel;
    }
    return result;
  }

  Future<CachedModel?> getModel(String id) async {
    CacheObject? cacheObject = await CacheHandler.getCacheObjectFromList(
        "network_faker_database_" + _id, "id", id);
    if (cacheObject == null) {
      return null;
    }
    return CachedModel(cacheObject.data);
  }
}

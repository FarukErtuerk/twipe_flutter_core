import 'package:flutter/foundation.dart';
import '../cache/cache_handler.dart';
import '../cache/cache_object.dart';
import '../model/model.dart';

abstract class Collection<T> {
  @protected
  final String _id;

  @protected
  Map<String, dynamic> _models = {};

  Collection(this._id);

  /// Load Model Data From Cache From Cache
  @protected
  Future<List<Map<String, dynamic>>> loadModelDataFromCache() async {
    List<Map<String, dynamic>> result = [];
    List<CacheObject> cache =
        await CacheHandler.getCacheList("collection_" + _id);
    for (CacheObject cacheObject in cache) {
      result.add(cacheObject.data);
    }
    return result;
  }

  /// Save Model to Cache
  @protected
  Future<void> saveModel(Model model, {bool applyHiddenFields = true}) async {
    await CacheHandler.saveCacheObjectToList(
        "collection_" + _id,
        CacheObject(model.getModelData(applyHiddenFields: applyHiddenFields)),
        "id");
  }

  /// Initialize your Model Data Here
  Future<void> setup();

  /// Returns Collection Id
  String getId() {
    return _id;
  }

  /// Returns Models In Collection
  Map<String, T> getModels() {
    return _models.cast<String, T>();
  }

  /// Returns Model With Specific Value
  T? getModelByFieldValue(String key, String value) {
    for (dynamic model in _models.values) {
      if (model.getModelData(applyHiddenFields: false)[key] == value) {
        return model as T;
      }
    }
    return null;
  }

  /// Creates Model From Model Data
  T? createModel(Map<String, dynamic> modelData);

  /// Adds Model To Collection
  bool addModel(dynamic model) {
    if (!model.validate()) {
      return false;
    }
    _models[model.getId()] = model;
    return true;
  }
}

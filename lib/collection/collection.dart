import 'package:flutter/foundation.dart';
import 'package:twipe_flutter_core/model/cached_model.dart';
import '../cache/cache_handler.dart';
import '../cache/cache_object.dart';
import '../model/model.dart';

/// Collection class contains Models and handles them
abstract class Collection<T> {
  @protected
  final String _id;

  @protected
  Map<String, dynamic> _models = {};

  Collection(this._id);

  /// Load Model Data From Cache From Cache
  @protected
  Future<List<CachedModel>> loadModelDataFromCache() async {
    List<CachedModel> result = [];
    List<CacheObject> cache =
        await CacheHandler.getCacheList("collection_" + _id);
    for (CacheObject cacheObject in cache) {
      result.add(CachedModel(cacheObject.data));
    }
    return result;
  }

  /// Save Model to Cache and add to Map
  Future<bool> saveModel(Model model, {bool applyHiddenFields = true}) async {
    if (!model.validate()) {
      return false;
    }
    if (!await CacheHandler.saveCacheObjectToList(
        "collection_" + _id,
        CacheObject(model.getModelData(applyHiddenFields: applyHiddenFields)),
        "id")) {
      return false;
    }
    _models[model.getId()] = model;
    return true;
  }

  /// Initialize your Model Data Here
  Future<void> setup();

  /// Returns Collection Id
  String getId() {
    return _id;
  }

  void setModels(Map<String, T> models) {
    _models = models;
  }

  /// Returns Models In Collection
  Map<String, T> getModels() {
    return _models.cast<String, T>();
  }

  /// Returns Model by Id
  T getModelById(String id) {
    return _models[id]!;
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
}

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cache/cache_handler.dart';
import '../../cache/cache_object.dart';
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
  Future<List<CacheObject>> loadModelDataFromCache() async {
    return await CacheHandler.getCacheList("collection_" + _id);
  }

  /// Save Model to Cache and add to Map
  Future<bool> saveModel(Model model) async {
    if (!model.validate()) {
      return false;
    }
    if (!await CacheHandler.saveCacheObjectToList(
        "collection_" + _id, model.toCacheObject(), "id")) {
      return false;
    }
    _models[model.getId()] = model;
    return true;
  }

  Future<bool> removeModelById(String id) async {
    if (!await CacheHandler.removeCacheObjectFromList(
        "collection_" + _id, id, "id")) {
      return false;
    }
    _models.remove(id);
    return true;
  }

  Future<bool> clear() async {
    if (!await CacheHandler.removeCacheObject("collection_" + _id)) {
      return false;
    }
    _models.clear();
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

  /// Collection contains Model with id
  bool hasModel(String id) {
    return _models.containsKey(id);
  }

  /// Returns Model by Id
  T? getModelById(String id) {
    return _models[id];
  }

  /// Returns Model With Specific Value
  T? getModelByFieldValue(String key, dynamic value) {
    for (dynamic model in _models.values) {
      if (model.getModelData(applyHiddenFields: false)[key] == value) {
        return model as T;
      }
    }
    return null;
  }

  /// Create new Model from Data
  T? createModel(Map<String, dynamic> modelData);
}

import 'package:flutter/foundation.dart';

abstract class Collection<T> {
  @protected
  final String _id;

  Map<String, dynamic> _models = {};

  Collection(this._id);

  Future<void> setup() async {}

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

import 'package:flutter/foundation.dart';

abstract class Model {
  @protected
  final Map<String, dynamic> _modelData;

  @protected
  final List<String> requiredFields = [];

  @protected
  final List<String> hiddenFields = [];

  @protected
  final List<String> baseFields = ["id", "created_at", "updated_at"];

  /// Model Id
  @protected
  String? _id;

  /// Model Constructor
  Model(this._modelData) {
    if (!_modelData.containsKey("id")) {
      throw UnsupportedError("Model Requires Field :id");
    }
    this._id = _modelData["id"];
  }

  /// Validates Model Data
  bool validate() {
    for (String key in requiredFields) {
      if (!_modelData.containsKey(key)) {
        return false;
      }
    }
    for (String key in baseFields) {
      if (!_modelData.containsKey(key)) {
        return false;
      }
    }
    return true;
  }

  /// Returns Model Data With Options
  Map<String, dynamic> getModelData({bool applyHiddenFields = true}) {
    if (applyHiddenFields) {
      Map<String, dynamic> tmp = _modelData;
      for (String key in hiddenFields) {
        tmp.remove(key);
      }
      return tmp;
    }
    return _modelData;
  }

  /// Returns Model ID
  @protected
  String getId() {
    return _id!;
  }
}

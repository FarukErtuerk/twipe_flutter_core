import 'package:flutter/foundation.dart';

abstract class Model {
  @protected
  final Map<String, dynamic> _modelData;

  /// Required Fields will be checked in validation
  @protected
  List<String> get requiredFields;

  /// You can define your hidden fields here and trim them when requesting Model Data
  @protected
  List<String> get hiddenFields;

  /// Do Not Edit this, except you know what you are doing
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
    if (!_validateField(requiredFields)) {
      return false;
    }
    if (!_validateField(baseFields)) {
      return false;
    }
    return true;
  }

  /// Validate Specific Field Array
  @protected
  bool _validateField(List<String> field) {
    for (String key in field) {
      if (key.contains("|")) {
        List<String> keys = key.split("|");
        if (!_modelData.containsKey(keys[0]) &&
            !_modelData.containsKey(keys[1])) {
          return false;
        }
      } else {
        if (!_modelData.containsKey(key)) {
          return false;
        }
      }
    }
    return true;
  }

  /// Returns Model Data With Options
  Map<String, dynamic> getModelData({bool applyHiddenFields = false}) {
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
  String getId() {
    return _id!;
  }
}

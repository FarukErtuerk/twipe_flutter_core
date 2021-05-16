import 'package:flutter/foundation.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import '../cache/cache_object.dart';
import '../cache/cacheable.dart';

/// Model class handles your Data
abstract class Model with Cacheable {
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

  /// Return Model id
  String getId() {
    return _id!;
  }

  /// Returns Creation Date
  int getCreatedAt() {
    return int.parse(_modelData["created_at"].toString());
  }

  /// Returns Update Date
  int getUpdatedAt() {
    return int.parse(_modelData["updated_at"].toString());
  }

  String getStringValue(String key, {String defaultValue = ""}) {
    return Field.getString(_modelData[key], defaultValue);
  }

  int getIntValue(String key, {int defaultValue = 0}) {
    return Field.getInt(_modelData[key], defaultValue);
  }

  bool getBoolValue(String key, {bool defaultValue = false}) {
    return Field.getBool(_modelData[key], defaultValue);
  }

  double getDoubleValue(String key, {double defaultValue = 0}) {
    return Field.getDouble(_modelData[key], defaultValue);
  }

  @override
  CacheObject toCacheObject() {
    return CacheObject(getModelData());
  }
}

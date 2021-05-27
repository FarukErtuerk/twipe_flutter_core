import 'package:flutter/foundation.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/field/field_validator.dart';

abstract class JSONObject {
  @protected
  Map<String, dynamic> _data;

  /// Required Fields will be checked in validation
  @protected
  List<String> get validator;

  JSONObject(this._data);

  Map<String, dynamic> getData() {
    return _data;
  }

  /// Returns Map with specified Keys in `List<String> keys`
  Map<String, dynamic> getOnly(List<String> keys) {
    Map<String, dynamic> result = {};
    for (String key in keys) {
      result[key] = _data[key];
    }
    return result;
  }

  setValue(String key, dynamic value) {
    _data[key] = value;
  }

  setData(Map<String, dynamic> data) {
    _data = data;
  }

  /// Validates Data
  @mustCallSuper
  bool validate() {
    return FieldValidator.validate(validator, getData());
  }

  String getStringValue(String key, {String defaultValue = ""}) {
    return Field.getString(getData()[key], defaultValue);
  }

  int getIntValue(String key, {int defaultValue = 0}) {
    return Field.getInt(getData()[key], defaultValue);
  }

  bool getBoolValue(String key, {bool defaultValue = false}) {
    return Field.getBool(getData()[key], defaultValue);
  }

  double getDoubleValue(String key, {double defaultValue = 0}) {
    return Field.getDouble(getData()[key], defaultValue);
  }
}

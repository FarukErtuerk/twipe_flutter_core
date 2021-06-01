import 'package:twipe_flutter_core/utils/field/field.dart';

class FieldValidator {
  /// Example [name=required&&max:255, email=required, password=required&&max:32]
  static bool validate(List<String> fields, Map<String, dynamic> data) {
    for (String field in fields) {
      if (!_FieldValidatorHelper.parse(field).validate(data)) {
        return false;
      }
    }
    return true;
  }
}

class _FieldValidatorHelper {
  String name;
  int max = 0;
  int min = 0;
  bool isRequired = false;
  _FieldValidatorHelper(this.name,
      {this.isRequired = false, this.max = 0, this.min = 0});

  factory _FieldValidatorHelper.parse(String value) {
    List<String> tmp = value.split("=");
    List<String> values = tmp[1].split("&&");
    int max = 0;
    int min = 0;
    bool isRequired = false;
    for (int i = 0; i < values.length; i++) {
      String tmp = values[i];
      if (tmp.startsWith("max:")) {
        max = Field.getInt(tmp.substring(4), 0);
      } else if (tmp.startsWith("min:")) {
        min = Field.getInt(tmp.substring(4), 0);
      } else if (tmp == "required") {
        isRequired = true;
      }
    }
    return _FieldValidatorHelper(tmp[0],
        max: max, min: min, isRequired: isRequired);
  }
  bool validate(Map<String, dynamic> data) {
    if (!data.containsKey(name) || data[name] == null) {
      return !isRequired;
    }
    dynamic tmp = data[name];
    if (tmp.runtimeType == String) {
      String s = Field.getString(tmp, "");
      if (min > 0 && s.length < min) {
        return false;
      }
      if (max > 0 && s.length > max) {
        return false;
      }
    }
    return true;
  }
}

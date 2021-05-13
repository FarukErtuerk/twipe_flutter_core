import 'package:flutter/services.dart' show rootBundle;
import '../field/field.dart';

class EnvironmentHandler {
  static Map<String, dynamic> _data = {};
  static Future<void> setup({String configFilePath = ".env"}) async {
    try {
      String raw = await rootBundle.loadString(configFilePath);
      if (raw.isNotEmpty && raw.contains("=")) {
        List<String> columns = raw.split("\n");
        for (String column in columns) {
          List<String> list = column.split("=");
          _data[list[0]] = list[1];
        }
      }
    } catch (e) {
      throw e;
    }
  }

  static String getStringValue(String key, {String defaultValue = ""}) {
    return Field.getString(_data[key], defaultValue);
  }

  static int getIntValue(String key, {int defaultValue = 0}) {
    return Field.getInt(_data[key], defaultValue);
  }

  static bool getBoolValue(String key, {bool defaultValue = false}) {
    return Field.getBool(_data[key], defaultValue);
  }

  static Map<String, dynamic> getConfig() {
    return _data;
  }
}

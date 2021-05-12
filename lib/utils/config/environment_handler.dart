import 'package:flutter/services.dart' show rootBundle;

import '../field/field.dart';

class EnvironmentHandler {
  static Map<String, dynamic> data = {};
  static Future<void> setup() async {
    try {
      String raw = await rootBundle.loadString(".env");
      print("Raw: " + raw);
      List<String> columns = raw.split("\n");
      for (String column in columns) {
        List<String> list = column.split("=");
        data[list[0]] = list[1];
      }
      print(data);
    } catch (e) {
      throw e;
    }
  }

  static String getStringValue(String key, {String defaultValue = ""}) {
    return Field.getString(data[key], defaultValue);
  }

  static int getIntValue(String key, {int defaultValue = 0}) {
    return Field.getInt(data[key], defaultValue);
  }

  static bool getBoolValue(String key, {bool defaultValue = false}) {
    return Field.getBool(data[key], defaultValue);
  }
}

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:twipe_flutter_core/utils/resources/resources.dart';
import '../field/field.dart';

class Environment {
  static Map<String, dynamic> _data = {};
  static Future<void> setup({String? configFilePath}) async {
    configFilePath =
        configFilePath ?? Resources.getResource('resources/env.env');
    try {
      String raw = await rootBundle.loadString(configFilePath);
      if (raw.isNotEmpty && raw.contains("=")) {
        List<String> columns = raw.split("\r\n");
        for (String column in columns) {
          List<String> list = column.split("=");
          String configListData = Field.getString(list[1], "");
          if (configListData.startsWith("[") && configListData.endsWith("]")) {
            _data[list[0]] = jsonDecode(configListData);
          } else {
            _data[list[0]] = list[1];
          }
        }
      }
    } catch (e) {
      throw e;
    }
    _validate(configFilePath, "CACHE_KEY");
    _validate(configFilePath, "JSON_FILES");
  }

  static _validate(String configFilePath, String key) {
    if (!_data.containsKey(key)) {
      throw Exception("Environment Handler: " +
          configFilePath +
          " File not contains : (" +
          key +
          ")");
    }
  }

  static List<dynamic> getList(String key) {
    return _data[key];
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

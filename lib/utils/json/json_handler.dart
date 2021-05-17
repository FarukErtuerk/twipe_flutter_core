import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:twipe_flutter_core/utils/config/environment_handler.dart';

class JSONHandler {
  static Map<String, Map<String, dynamic>> _json = {};
  static Future<void> setup() async {
    try {
      for (String file in EnvironmentHandler.getListString("JSON_CONFIG")) {
        String raw =
            await rootBundle.loadString("resources/json/" + file + ".json");
        Map<String, dynamic> map = jsonDecode(raw);
        _json[file] = map;
      }
    } catch (e) {
      throw e;
    }
  }

  static Map<String, dynamic> getJSON(String key) {
    return _json[key]!;
  }
}

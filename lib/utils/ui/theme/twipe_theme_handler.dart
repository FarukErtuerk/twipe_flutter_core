import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';
import '../../field/field.dart';

class TwipeThemeHandler {
  static Map<String, TwipeTheme> _themes = {};
  static Future<void> setup() async {
    try {
      String raw = await rootBundle.loadString("resources/styles/themes.json");
      if (raw.isNotEmpty) {
        Map<String, dynamic> map = jsonDecode(raw);

        for (String key in map.keys) {
          String themeName = key;
          Map<String, dynamic> themeData = map[key];
          Map<String, dynamic> semantic = themeData["semantic"];
          Map<String, dynamic> neutral = themeData["neutral"];
          Map<String, dynamic> colors = themeData["colors"];
          Map<String, Color> resultColors = {};
          for (String colorKey in colors.keys) {
            resultColors[colorKey] =
                HexColor.fromHex(Field.getString(colors[colorKey], "#FFFFFF"));
          }
          _themes[themeName] = TwipeTheme(
              HexColor.fromHex(
                  Field.getString(themeData["primary"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(themeData["accent"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(semantic["error"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(semantic["warning"], "#FFFFFF")),
              HexColor.fromHex(
                  Field.getString(semantic["information"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(semantic["succes"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(neutral["text"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(neutral["border"], "#FFFFFF")),
              HexColor.fromHex(Field.getString(neutral["icon"], "#FFFFFF")),
              resultColors);
        }
      }
    } catch (e) {
      throw e;
    }
  }

  static TwipeTheme getTheme(String key) {
    return _themes[key]!;
  }
}

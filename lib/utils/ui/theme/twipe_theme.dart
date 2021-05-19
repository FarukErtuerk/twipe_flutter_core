import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/resources/resources.dart';
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';
import 'package:flutter/services.dart' show rootBundle;

class TwipeTheme {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color error;
  final Color warning;
  final Color information;
  final Color succes;
  final Color text;
  final Color border;
  final Color icon;
  final Map<String, Color> colors;
  TwipeTheme(
      this.primary,
      this.secondary,
      this.accent,
      this.error,
      this.warning,
      this.information,
      this.succes,
      this.text,
      this.border,
      this.icon,
      this.colors);

  /// Get Color from `colors`
  Color getColor(String key) {
    return colors[key]!;
  }

  static Map<String, TwipeTheme> _themes = {};
  static Future<void> setup() async {
    try {
      String raw =
          await rootBundle.loadString(Resources.getStylePath('themes'));
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
              HexColor.fromHex(
                  Field.getString(themeData["secondary"], "#FFFFFF")),
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

  static TwipeTheme of(String key) {
    return _themes[key]!;
  }
}

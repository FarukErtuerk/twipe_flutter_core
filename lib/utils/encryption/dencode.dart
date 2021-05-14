import 'package:flutter/foundation.dart';

class DEncode {
  /// Encodes String
  static String encode(String key, String value) {
    if (key.isEmpty) {
      return value;
    }
    List<String> keyList =
        key.runes.map((rune) => String.fromCharCode(rune)).toList();
    int currentKeyPos = 0;
    String result = "";
    List<String> tmp =
        value.runes.map((rune) => String.fromCharCode(rune)).toList();
    int counter = 0;
    for (String s in tmp) {
      result += _calculateStringFromKey(keyList[currentKeyPos], s, key);
      if (counter < tmp.length - 1) {
        result = result + "a";
      }
      currentKeyPos++;
      if (currentKeyPos >= keyList.length) {
        currentKeyPos = 0;
      }
      counter++;
    }
    return result;
  }

  @protected
  static String _calculateStringFromKey(
      String key, String value, String fullKey) {
    String result = "";
    int a = key.codeUnitAt(0);
    int b = value.codeUnitAt(0);
    result = (a + b).toString();
    return result;
  }

  /// Decodes String from encrypted Value
  static String decode(String key, String value) {
    if (key.isEmpty) {
      return value;
    }
    List<String> keyList =
        key.runes.map((rune) => String.fromCharCode(rune)).toList();

    int currentKeyPos = 0;
    String result = "";

    List<String> tmp = value.split("a");
    for (String s in tmp) {
      result += _calculateKeyFromString(keyList[currentKeyPos], s, key);
      currentKeyPos++;
      if (currentKeyPos >= keyList.length) {
        currentKeyPos = 0;
      }
    }
    return result;
  }

  @protected
  static String _calculateKeyFromString(
      String key, String value, String fullKey) {
    String result = "";
    int a = key.codeUnitAt(0);
    int b = int.parse(value);
    int tmp = b - a;
    if (tmp < 0 || tmp > 1114111) {
      return "";
    }
    result = String.fromCharCode(tmp);
    return result;
  }
}

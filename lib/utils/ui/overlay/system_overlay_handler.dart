import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// System Overlay Handler
/// Apply Color to Application and dont worry about anything
class SystemOverlayHandler {
  static flat(Color color) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    if (brightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: color,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: color));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: color,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: color));
    }
  }
}

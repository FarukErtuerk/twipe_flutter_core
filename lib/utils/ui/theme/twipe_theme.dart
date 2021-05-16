import 'package:flutter/material.dart';

class TwipeTheme {
  final Color primary;
  final Color accent;
  final Color error;
  final Color warning;
  final Color information;
  final Color succes;
  final Color text;
  final Color border;
  final Color icons;
  final Map<String, Color> colors;
  TwipeTheme(
      this.primary,
      this.accent,
      this.error,
      this.warning,
      this.information,
      this.succes,
      this.text,
      this.border,
      this.icons,
      this.colors);

  Color getColor(String key) {
    return colors[key]!;
  }
}

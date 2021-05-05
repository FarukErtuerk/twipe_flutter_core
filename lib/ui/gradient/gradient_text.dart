import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Creates Gradient Text
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final List<Color> colors;

  final Alignment gradientBegin;
  final Alignment gradientEnd;

  final List<double>? stops;

  GradientText(this.text, this.colors, this.textStyle,
      {this.gradientBegin = Alignment.centerLeft,
      this.gradientEnd = Alignment.centerRight,
      this.stops});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        final gradient = LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: colors,
            stops: stops);
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        text,
        style: textStyle.copyWith(color: Colors.white),
      ),
    );
  }
}

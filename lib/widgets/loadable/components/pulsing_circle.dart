import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/widgets/loadable/loadable_widget.dart';

class PulsingCircle extends StatelessWidget {
  final LoadableWidget loadableWidget;
  final Color backgroundColor;
  final Color valueColor;
  final double size;
  final BorderRadius? borderRadius;
  PulsingCircle(this.loadableWidget, this.size,
      {this.backgroundColor = Colors.blue,
      this.valueColor = Colors.lightBlueAccent,
      this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      foregroundDecoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(size),
          color: valueColor
              .withOpacity(loadableWidget.getAnimationController().value)),
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(size),
          color: backgroundColor),
    );
  }
}

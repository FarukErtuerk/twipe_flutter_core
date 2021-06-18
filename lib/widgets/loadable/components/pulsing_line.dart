import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/widgets/loadable/loadable_widget.dart';

class PulsingLine extends StatelessWidget {
  final LoadableWidget loadableWidget;
  final Color backgroundColor;
  final Color valueColor;
  final double? width, heigth;
  final BorderRadius? borderRadius;
  final Alignment? begin, end;
  PulsingLine(this.loadableWidget,
      {this.backgroundColor = Colors.blue,
      this.valueColor = Colors.lightBlueAccent,
      this.width,
      this.heigth,
      this.borderRadius,
      this.begin,
      this.end});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigth,
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [backgroundColor, valueColor, backgroundColor],
              begin: begin ?? Alignment.centerLeft,
              end: end ?? Alignment.centerRight,
              stops: [0, loadableWidget.getAnimationController().value, 1])),
    );
  }
}

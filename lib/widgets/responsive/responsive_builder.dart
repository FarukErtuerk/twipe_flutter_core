import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';
import 'package:twipe_flutter_core/widgets/responsive/responsive_builder_mixin.dart';

class ResponsiveBuilder extends StatelessWidget with ResponsiveBuilderMixin {
  final WidgetBuilder mobileSmall;
  final WidgetBuilder mobileMedium;
  final WidgetBuilder mobileLarge;
  final WidgetBuilder tablet;
  final WidgetBuilder laptop;
  final WidgetBuilder laptopLarge;
  final WidgetBuilder fourK;
  ResponsiveBuilder(this.mobileSmall, this.mobileMedium, this.mobileLarge,
      this.tablet, this.laptop, this.laptopLarge, this.fourK);
  @override
  Widget build(BuildContext context) {
    if (Configuration.isScreen(context, fourK: true)) {
      return buildFourK(context);
    } else if (Configuration.isScreen(context, laptopLarge: true)) {
      return buildLaptopLarge(context);
    } else if (Configuration.isScreen(context, laptop: true)) {
      return buildLaptop(context);
    } else if (Configuration.isScreen(context, tablet: true)) {
      return buildTablet(context);
    } else if (Configuration.isScreen(context, mobileLarge: true)) {
      return buildMobileLarge(context);
    } else if (Configuration.isScreen(context, mobileMedium: true)) {
      return buildMobileMedium(context);
    }
    return buildMobileSmall(context);
  }

  @override
  Widget buildFourK(BuildContext context) {
    return fourK(context);
  }

  @override
  Widget buildLaptop(BuildContext context) {
    return laptop(context);
  }

  @override
  Widget buildLaptopLarge(BuildContext context) {
    return laptopLarge(context);
  }

  @override
  Widget buildMobileLarge(BuildContext context) {
    return mobileLarge(context);
  }

  @override
  Widget buildMobileMedium(BuildContext context) {
    return mobileMedium(context);
  }

  @override
  Widget buildMobileSmall(BuildContext context) {
    return mobileSmall(context);
  }

  @override
  Widget buildTablet(BuildContext context) {
    return tablet(context);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';

/// Responsive Widget applies build Method to given Screen Size
abstract class ResponsiveWidget extends StatelessWidget {
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

  Widget buildFourK(BuildContext context);

  Widget buildLaptopLarge(BuildContext context);

  Widget buildLaptop(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildMobileLarge(BuildContext context);

  Widget buildMobileMedium(BuildContext context);

  Widget buildMobileSmall(BuildContext context);
}

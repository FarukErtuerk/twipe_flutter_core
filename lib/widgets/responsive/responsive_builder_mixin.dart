import 'package:flutter/cupertino.dart';

/// Responsive Widget applies build Method to given Screen Size
mixin ResponsiveBuilderMixin {
  Widget buildFourK(BuildContext context);

  Widget buildLaptopLarge(BuildContext context);

  Widget buildLaptop(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildMobileLarge(BuildContext context);

  Widget buildMobileMedium(BuildContext context);

  Widget buildMobileSmall(BuildContext context);

  Widget buildDefault(BuildContext context);
}

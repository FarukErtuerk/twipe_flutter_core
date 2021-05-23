import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/json/json_handler.dart';

class Configuration {
  static Dimension _dimension =
      Dimension.fromMap(JSONHandler.getJSON('config')['dimension']);

  /// Returns `Dimension`
  static Dimension getDimension() {
    return _dimension;
  }

  /// Returns Responsive Font Size declared in `resources/json/config.json`
  static double getFontSize(BuildContext context, String text) {
    if (isScreen(context, mobileSmall: true)) {
      return Field.getDouble(_dimension.textMobileSmall[text], 0);
    }
    if (isScreen(context, mobileMedium: true)) {
      return Field.getDouble(_dimension.textMobileMedium[text], 0);
    }
    if (isScreen(context, mobileLarge: true)) {
      return Field.getDouble(_dimension.textMobileLarge[text], 0);
    }
    if (isScreen(context, tablet: true)) {
      return Field.getDouble(_dimension.textTablet[text], 0);
    }
    if (isScreen(context, laptop: true)) {
      return Field.getDouble(_dimension.textLaptop[text], 0);
    }
    if (isScreen(context, laptopLarge: true)) {
      return Field.getDouble(_dimension.textLaptopLarge[text], 0);
    }

    return Field.getDouble(_dimension.textFourK[text], 0);
  }

  /// Screen `equals` or is `greater` than.
  static bool isScreen(BuildContext context,
      {bool mobileSmall = false,
      bool mobileMedium = false,
      bool mobileLarge = false,
      bool tablet = false,
      bool laptop = false,
      bool laptopLarge = false,
      bool fourK = false}) {
    double width = MediaQuery.of(context).size.width;
    if (mobileSmall && width >= _dimension.mobileSmall) {
      return true;
    }
    if (mobileMedium && width >= _dimension.mobileMedium) {
      return true;
    }
    if (mobileLarge && width >= _dimension.mobileLarge) {
      return true;
    }
    if (tablet && width >= _dimension.tablet) {
      return true;
    }
    if (laptop && width >= _dimension.laptop) {
      return true;
    }
    if (laptopLarge && width >= _dimension.laptopLarge) {
      return true;
    }
    if (fourK && width >= _dimension.fourK) {
      return true;
    }

    return false;
  }
}

class Dimension {
  final double mobileSmall;
  final double mobileMedium;
  final double mobileLarge;
  final double tablet;
  final double laptop;
  final double laptopLarge;
  final double fourK;

  final Map<String, dynamic> textMobileSmall;
  final Map<String, dynamic> textMobileMedium;

  final Map<String, dynamic> textMobileLarge;

  final Map<String, dynamic> textTablet;

  final Map<String, dynamic> textLaptop;

  final Map<String, dynamic> textLaptopLarge;

  final Map<String, dynamic> textFourK;
  Dimension(
      this.mobileSmall,
      this.mobileMedium,
      this.mobileLarge,
      this.tablet,
      this.laptop,
      this.laptopLarge,
      this.fourK,
      this.textMobileSmall,
      this.textMobileMedium,
      this.textMobileLarge,
      this.textTablet,
      this.textLaptop,
      this.textLaptopLarge,
      this.textFourK);

  factory Dimension.fromMap(Map<String, dynamic> map) {
    return Dimension(
        Field.getDouble(map['mobile_small']['size'], 320),
        Field.getDouble(map['mobile_medium']['size'], 375),
        Field.getDouble(map['mobile_large']['size'], 425),
        Field.getDouble(map['tablet']['size'], 768),
        Field.getDouble(map['laptop']['size'], 1024),
        Field.getDouble(map['laptop_large']['size'], 1440),
        Field.getDouble(map['four_k']['size'], 2560),
        map['mobile_small']['text'],
        map['mobile_medium']['text'],
        map['mobile_large']['text'],
        map['tablet']['text'],
        map['laptop']['text'],
        map['laptop_large']['text'],
        map['four_k']['text']);
  }
}

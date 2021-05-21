import 'package:flutter/cupertino.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/json/json_handler.dart';

class Configuration {
  static Dimension _dimension =
      Dimension.fromMap(JSONHandler.getJSON('config')['dimension']);

  static Dimension getDimension() {
    return _dimension;
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

  Dimension(this.mobileSmall, this.mobileMedium, this.mobileLarge, this.tablet,
      this.laptop, this.laptopLarge, this.fourK);

  factory Dimension.fromMap(Map<String, dynamic> map) {
    return Dimension(
        Field.getDouble(map['mobile_small'], 320),
        Field.getDouble(map['mobile_medium'], 375),
        Field.getDouble(map['mobile_large'], 425),
        Field.getDouble(map['tablet'], 768),
        Field.getDouble(map['laptop'], 1024),
        Field.getDouble(map['laptop_large'], 1440),
        Field.getDouble(map['four_k'], 2560));
  }
}

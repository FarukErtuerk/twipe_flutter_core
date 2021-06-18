import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class ConfigurationTest extends Tester {
  @override
  Future<void> doTest() async {
    testValues([
      Configuration.getDimension().mobileSmall,
      Configuration.getDimension().mobileMedium,
      Configuration.getDimension().mobileLarge,
      Configuration.getDimension().tablet,
      Configuration.getDimension().laptop,
      Configuration.getDimension().laptopLarge,
      Configuration.getDimension().fourK,
    ], [
      320,
      375,
      425,
      768,
      1024,
      1440,
      2560,
    ], info: 'Testing Dimensions');
  }
}

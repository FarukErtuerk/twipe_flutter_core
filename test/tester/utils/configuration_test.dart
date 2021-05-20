import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class ConfigurationTest extends Tester {
  @override
  Future<void> doTest() async {
    testDimension(320, Configuration.getDimension().mobileSmall);
    testDimension(375, Configuration.getDimension().mobileMedium);
    testDimension(425, Configuration.getDimension().mobileLarge);
    testDimension(768, Configuration.getDimension().tablet);
    testDimension(1024, Configuration.getDimension().laptop);
    testDimension(1440, Configuration.getDimension().laptopLarge);
    testDimension(2560, Configuration.getDimension().fourK);
  }

  void testDimension(double expected, double actual) {
    test(
        'Testing Dimensions Expected:' +
            expected.toString() +
            " Actual:" +
            actual.toString(), () {
      expect(actual, expected);
    });
  }
}

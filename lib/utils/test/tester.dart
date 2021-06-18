/// Test Helper Class
import 'package:flutter_test/flutter_test.dart';

abstract class Tester {
  /// Run Test
  Future<void> doTest();

  /// Test multiple Doubles
  void testValues(List<dynamic> values, List<dynamic> expected,
      {String? info}) {
    for (int i = 0; i < values.length; i++) {
      test(
          info != null
              ? info +
                  ': Value: ' +
                  expected[i].toString() +
                  ' Expected: ' +
                  values[i].toString()
              : 'Value: ' +
                  expected[i].toString() +
                  ' Expected: ' +
                  values[i].toString(), () {
        expect(values[i], expected[i]);
      });
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/config/environment.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class EnvironmentTest extends Tester {
  @override
  Future<void> doTest() async {
    testKey('md02nv6alvny73i', Environment.getStringValue('CACHE_KEY'));
    testKey(["config"], Environment.getList('JSON_FILES'));
  }

  void testKey(dynamic expectation, dynamic value) {
    test(
        'Environment Test Expectation: ' +
            expectation.toString() +
            ' Value: ' +
            value.toString(), () {
      expect(expectation, value);
    });
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/config/environment.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class EnvironmentTest extends Tester {
  @override
  Future<void> doTest() async {
    testValues([
      'md02nv6alvny73i',
      ["config"]
    ], [
      Environment.getStringValue('CACHE_KEY'),
      Environment.getList('JSON_FILES')
    ], info: 'Testing Environment');
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class FieldTester extends Tester {
  @override
  Future<void> doTest() async {
    testValues([
      Field.getString('Hey, wie geht es dir?', ''),
      Field.getString('', 'Hey, wie geht es dir?'),
      Field.getString(null, 'Hey, wie geht es dir?'),
    ], [
      'Hey, wie geht es dir?',
      '',
      'Hey, wie geht es dir?',
    ], info: 'Testing Field');
  }
}

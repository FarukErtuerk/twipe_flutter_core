import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class FieldTester extends Tester {
  @override
  Future<void> doTest() async {
    test('Field test String Getter', () {
      /// Expects String
      expect("Hey, wie geht es dir?",
          Field.getString("Hey, wie geht es dir?", ""));

      /// Expect defaultValue
      expect("Hey, wie geht es dir?",
          Field.getString(null, "Hey, wie geht es dir?"));

      /// Expect Empty String because String exists
      expect("", Field.getString("", "Hey, wie geht es dir?"));
    });
  }
}

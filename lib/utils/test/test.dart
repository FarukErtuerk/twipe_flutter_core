import 'package:twipe_flutter_core/utils/test/tester.dart';

/// Use this when creating Tests
class Test {
  List<Tester> _testerList = [];

  /// Add new Test
  Test add(Tester tester) {
    _testerList.add(tester);
    return this;
  }

  /// Run Tests
  Future<void> doTest() async {
    for (Tester tester in _testerList) {
      await tester.doTest();
    }
  }
}

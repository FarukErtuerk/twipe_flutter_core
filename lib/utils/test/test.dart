import 'package:twipe_flutter_core/utils/test/tester.dart';

class Test {
  List<Tester> _testerList = [];
  Test add(Tester tester) {
    _testerList.add(tester);
    return this;
  }

  Future<void> doTest() async {
    for (Tester tester in _testerList) {
      await tester.doTest();
    }
  }
}

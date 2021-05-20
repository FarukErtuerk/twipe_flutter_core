import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/_dev/_dev.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class AppTester extends Tester {
  @override
  Future<void> doTest() async {
    testWidgets('Test DevApp', (WidgetTester tester) async {
      await tester.pumpWidget(DevApp());
    });
  }
}

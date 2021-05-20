import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';

class ThemeTester extends Tester {
  @override
  Future<void> doTest() async {
    testThemeColor(
        '#FFA72608'.toLowerCase(), TwipeTheme.of('example').primary.toHex());
    testThemeColor(
        '#FFBBC5AA'.toLowerCase(), TwipeTheme.of('example').secondary.toHex());
    testThemeColor(
        '#FFE6EED6'.toLowerCase(), TwipeTheme.of('example').accent.toHex());
  }

  void testThemeColor(String expected, String actual) {
    test(
        'TwipeTheme testThemeColor Expected: ' +
            expected +
            ' Actual: ' +
            actual, () {
      expect(actual, expected);
    });
  }
}

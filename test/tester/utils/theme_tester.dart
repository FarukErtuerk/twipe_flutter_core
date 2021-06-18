import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';

class ThemeTester extends Tester {
  @override
  Future<void> doTest() async {
    testValues([
      TwipeTheme.of('example').primary.toHex(),
      TwipeTheme.of('example').secondary.toHex(),
      TwipeTheme.of('example').accent.toHex(),
    ], [
      '#FFA72608'.toLowerCase(),
      '#FFBBC5AA'.toLowerCase(),
      '#FFE6EED6'.toLowerCase(),
    ], info: 'Testing TwipeTheme');
  }
}

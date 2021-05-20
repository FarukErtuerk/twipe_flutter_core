import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/test/test.dart';
import 'helper/helper.dart';
import 'tester/app/app_tester.dart';
import 'tester/networking/network_tester.dart';
import 'tester/utils/configuration_test.dart';
import 'tester/utils/enryption_tester.dart';
import 'tester/utils/environment_test.dart';
import 'tester/utils/field_tester.dart';
import 'tester/utils/theme_tester.dart';

/// This will Test our Library
Future<void> main() async {
  /// Initialize Project
  TestWidgetsFlutterBinding.ensureInitialized();

  Helper helper = Helper();
  await helper.initialize();

  /// Do Test
  Test _test = Test();
  _test.add(ConfigurationTest());
  _test.add(EnvironmentTest());
  _test.add(EncryptionTester());
  _test.add(FieldTester());
  _test.add(NetworkTester());
  _test.add(ThemeTester());
  _test.add(AppTester());
  await _test.doTest();
}

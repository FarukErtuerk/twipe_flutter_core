import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/test/test.dart';
import 'helper/helper.dart';
import 'tester/app/app_tester.dart';
import 'tester/utils/configuration_test.dart';
import 'tester/utils/enryption_tester.dart';
import 'tester/utils/environment_test.dart';
import 'tester/utils/field_tester.dart';
import 'tester/utils/theme_tester.dart';

/// This will Test our Library
Future<void> main() async {
  /// Initialize Project
  TestWidgetsFlutterBinding.ensureInitialized();

  await Helper().initialize();

  /// Do Test
  await Test()
      .add(ConfigurationTest())
      .add(EnvironmentTest())
      .add(EncryptionTester())
      .add(FieldTester())
      .add(ThemeTester())
      .add(AppTester())
      .doTest();
}

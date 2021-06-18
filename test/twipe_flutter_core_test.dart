import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/utils/test/test.dart';
import 'tester/utils/configuration_test.dart';
import 'tester/utils/enryption_tester.dart';
import 'tester/utils/environment_test.dart';
import 'tester/utils/field_tester.dart';
import 'tester/utils/theme_tester.dart';

/// This will Test our Library
/// Run main Method for testing the Package
Future<void> main() async {
  /// Initialize Test Project
  TestWidgetsFlutterBinding.ensureInitialized();

  await TwipeFlutterCore.initialize(
      environmentFilePath: 'resources/env.env.example');

  /// Do Test
  await Test()
      .add(ConfigurationTest())
      .add(EnvironmentTest())
      .add(EncryptionTester())
      .add(FieldTester())
      .add(ThemeTester())
      .doTest();
}

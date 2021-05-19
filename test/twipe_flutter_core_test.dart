import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/utils/test/test.dart';

import 'app/app_tester.dart';
import 'utils/configuration_test.dart';

/// This will Test our Library
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await TwipeFlutterCore.initialize(configFilePath: 'resources/.env.example');
  Test _test = Test();
  _test.add(ConfigurationTest());
  _test.add(AppTester());
  await _test.doTest();
}

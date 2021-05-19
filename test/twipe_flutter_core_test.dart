import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';

/// This will Test the Library
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await TwipeFlutterCore.initialize(configFilePath: 'env.example');
  test('Testing', () {});
}

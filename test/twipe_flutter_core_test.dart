import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/utils/network/faker/network_faker.dart';
import 'package:twipe_flutter_core/utils/network/server/server.dart';
import 'package:twipe_flutter_core/utils/network/server/server_route.dart';
import 'package:twipe_flutter_core/utils/test/test.dart';
import 'app/app_tester.dart';
import 'helper/networking/fake/route/test_fake_auth_route.dart';
import 'helper/networking/test_network.dart';
import 'networking/network_tester.dart';
import 'utils/configuration_test.dart';
import 'utils/environment_test.dart';

TestNetwork? testNetwork;

/// This will Test our Library
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await TwipeFlutterCore.initialize(configFilePath: 'resources/.env.example');
  testNetwork = TestNetwork('test_network');
  Server server = await Server.localhost('test_server');
  server.addRoute(ServerRoute('test_route_create', 'test/auth/create'));
  NetworkFaker.addRoute(TestFakeAuthRoute('test_route_create'));
  testNetwork!.addServer(server);
  Test _test = Test();
  _test.add(ConfigurationTest());
  _test.add(EnvironmentTest());
  _test.add(NetworkTester());
  _test.add(AppTester());
  await _test.doTest();
}

TestNetwork getNetwork() {
  return testNetwork!;
}

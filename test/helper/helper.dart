import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/utils/network/faker/network_faker.dart';
import 'package:twipe_flutter_core/utils/network/server/server.dart';
import 'package:twipe_flutter_core/utils/network/server/server_route.dart';

import 'networking/fake/route/test_fake_auth_route.dart';
import 'networking/test_network.dart';

class Helper {
  static TestNetwork? _testNetwork;

  Future<void> initialize() async {
    await TwipeFlutterCore.initialize(configFilePath: 'resources/.env.example');
    _testNetwork = TestNetwork('test_network');
    Server server = await Server.localhost('test_server');
    server.addRoute(ServerRoute('test_route_create', 'test/auth/create'));
    NetworkFaker.addRoute(TestFakeAuthRoute('test_route_create'));
    _testNetwork!.addServer(server);
  }

  static TestNetwork getNetwork() {
    return _testNetwork!;
  }
}

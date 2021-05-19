import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/auth/auth.dart';
import 'package:twipe_flutter_core/utils/auth/auth_user.dart';
import 'package:twipe_flutter_core/utils/network/network_result.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

import '../twipe_flutter_core_test.dart';

class NetworkTester extends Tester {
  Auth auth = Auth('users');
  @override
  Future<void> doTest() async {
    await auth.setup();
    await userCanBeCreated();
  }

  Future<void> userCanBeCreated() async {
    test('Test Authentication', () async {
      NetworkResult networkResult =
          await getNetwork().call('test_server', 'test_route_create');
      AuthUser? authUser = auth.createModel(networkResult.getData());
      expect(false, authUser == null);
    });
  }
}

import 'dart:convert';

import 'package:twipe_flutter_core/utils/cutom/custom_data.dart';
import 'package:twipe_flutter_core/utils/network/faker/network_faker_request.dart';
import 'package:twipe_flutter_core/utils/network/faker/network_faker_route.dart';
import 'package:twipe_flutter_core/utils/network/network_result.dart';

class TestFakeAuthRoute extends NetworkFakerRoute {
  TestFakeAuthRoute(String id) : super(id);

  @override
  Future<NetworkResult> callback(
      NetworkFakerRequest networkFakerRequest) async {
    int millis = DateTime.now().millisecondsSinceEpoch;
    return NetworkResult.fromFaker(jsonEncode({
      "status": NetworkResult.done,
      "data": {
        "updated_at": millis,
        "created_at": millis,
        "id": 0,
        "email": "test.dev@test.com",
        "phone_number": "12345678900",
        "token": "token_" + CustomData.getInt().toString(),
        "password": "nasfna9rjfas"
      }
    }));
  }
}

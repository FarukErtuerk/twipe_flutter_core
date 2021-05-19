import 'network_faker_request.dart';
import '../network_result.dart';

abstract class NetworkFakerRoute {
  final String _id;

  NetworkFakerRoute(this._id);

  String getId() {
    return _id;
  }

  Future<NetworkResult> callback(NetworkFakerRequest networkFakerRequest);
}

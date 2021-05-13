import 'package:twipe_flutter_core/network/server/server.dart';
import 'package:twipe_flutter_core/network/server/server_route.dart';

class NetworkFakerRequest {
  final Server server;
  final ServerRoute serverRoute;
  final Uri uri;
  final int requestType;
  final Map<String, dynamic>? data;
  NetworkFakerRequest(
      this.server, this.serverRoute, this.data, this.requestType, this.uri);

  bool hasData() {
    return data != null;
  }
}

import 'network_faker_route.dart';

class NetworkFaker {
  static Map<String, NetworkFakerRoute> _routes = {};

  static void addRoute(NetworkFakerRoute networkFakerRoute) {
    _routes[networkFakerRoute.getId()] = networkFakerRoute;
  }

  static NetworkFakerRoute getRoute(String id) {
    return _routes[id]!;
  }

  static bool hasRoute(String id) {
    return _routes.containsKey(id);
  }
}

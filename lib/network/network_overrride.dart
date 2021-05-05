import 'dart:io';

/// Overrides bad Certificate Callback
class NetworkOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    return client;
  }

  @override
  String findProxyFromEnvironment(Uri url, Map<String, String>? environment) {
    return super.findProxyFromEnvironment(url, environment);
  }

  static void applyOverride(HttpOverrides httpOverrides) {
    HttpOverrides.global = httpOverrides;
  }
}

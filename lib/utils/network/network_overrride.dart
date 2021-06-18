import 'dart:io';
import 'override/skip_bad_certificate.dart';

/// Overrides Certificate Callback
class NetworkOverride extends HttpOverrides with SkipBadCerticifate {
  final bool skipBadCertificate;
  NetworkOverride({this.skipBadCertificate = true});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context);
    if (skipBadCertificate) {
      client.badCertificateCallback = applySkipBadCerticifate;
    }
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

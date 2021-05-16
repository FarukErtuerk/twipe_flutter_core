import 'dart:io';

mixin SkipBadCerticifate {
  bool skip(X509Certificate cert, String host, int port) {
    return true;
  }
}

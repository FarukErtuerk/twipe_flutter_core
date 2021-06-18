import 'dart:io';

mixin SkipBadCerticifate {
  bool applySkipBadCerticifate(X509Certificate cert, String host, int port) {
    return true;
  }
}

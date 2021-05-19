import 'package:flutter/foundation.dart';

/// Server Route Representing Any Routes In Your Network
/// Static Route
/// /auth/signin
/// Dynamic Route
/// /user/{id}/posts/get
class ServerRoute {
  /// Server Route Id
  @protected
  final String _id;

  /// Server Route Path
  @protected
  final String _path;

  /// Default Route Header
  @protected
  Map<String, dynamic> _defaultHeader = {};

  /// Default Route Body
  @protected
  Map<String, dynamic> _defaultBody = {};

  ServerRoute(this._id, this._path,
      {Map<String, String>? defaultHeader, Map<String, String>? defaultBody}) {
    _defaultBody = defaultBody ?? {};
    _defaultHeader = defaultHeader ?? {};
  }

  /// Returns Route Id
  String getId() {
    return _id;
  }

  /// Returns Default Header
  Map<String, dynamic> getDefaultHeader() {
    return _defaultHeader;
  }

  /// Returns Default Body
  Map<String, dynamic> getDefaultBody() {
    return _defaultBody;
  }

  /// Returns Path With Given Replacements
  String getPath({Map<String, String>? replacements}) {
    String result = _path;
    if (replacements != null) {
      for (String key in replacements.keys) {
        result = result.replaceAll("{" + key + "}", replacements[key]!);
      }
    }
    if (!result.startsWith("/")) {
      result = "/" + result;
    }
    return result;
  }
}

import 'package:flutter/foundation.dart';
import '../cookie/cookie_handler.dart';
import 'server_route.dart';

/// This Class Represents A Server
/// http://www.example.com
/// isHttp = true, host = www.example.com, port = -1
///
/// https://127.0.0.1:5588
/// isHttp = false, host = 127.0.0.1, port = 5588
class Server {
  /// Server Id
  @protected
  final String _id;

  /// Server Host
  @protected
  final String _host;

  /// Server Port
  @protected
  final int _port;

  /// Server Is Http Encrypted
  @protected
  final bool _isHttp;

  /// Server Routes
  @protected
  Map<String, ServerRoute> _routes = {};

  /// Cookie Handler
  @protected
  CookieHandler _cookieHandler;

  /// Default Server Header
  @protected
  Map<String, dynamic> _defaultHeader = {};

  /// Default Server Body
  @protected
  Map<String, dynamic> _defaultBody = {};

  Server(this._id, this._host, this._port, this._isHttp, this._cookieHandler,
      this._defaultHeader, this._defaultBody);

  /// Creates Server From Host And Port
  static Future<Server> fromHostAndPort(String id, String host, int port,
      {bool isHttp = true,
      Map<String, dynamic>? defaultHeader,
      Map<String, dynamic>? defaultBody}) async {
    CookieHandler cookieHandler = CookieHandler(id);
    await cookieHandler.loadCookies();
    return Server(id, host, port, isHttp, cookieHandler, defaultHeader ?? {},
        defaultBody ?? {});
  }

  /// Creates Server From Host
  static Future<Server> fromHost(String id, String host,
      {bool isHttp = true,
      Map<String, dynamic>? defaultHeader,
      Map<String, dynamic>? defaultBody}) async {
    CookieHandler cookieHandler = CookieHandler(id);
    await cookieHandler.loadCookies();
    return Server(id, host, -1, isHttp, cookieHandler, defaultHeader ?? {},
        defaultBody ?? {});
  }

  /// Creates Server From Localhost
  static Future<Server> localhost(String id,
      {bool withNumbers = false,
      bool isHttp = true,
      Map<String, dynamic>? defaultHeader,
      Map<String, dynamic>? defaultBody}) async {
    CookieHandler cookieHandler = CookieHandler(id);
    await cookieHandler.loadCookies();
    return Server(id, withNumbers ? "127.0.0.1" : "localhost", -1, isHttp,
        cookieHandler, defaultHeader ?? {}, defaultBody ?? {});
  }

  /// Adds Route To Server
  void addRoute(ServerRoute serverRoute) {
    _routes[serverRoute.getId()] = serverRoute;
  }

  /// Returns Default Header
  Map<String, dynamic> getDefaultHeader() {
    return _defaultHeader;
  }

  /// Returns Default Body
  Map<String, dynamic> getDefaultBody() {
    return _defaultBody;
  }

  /// Returns Route By Id
  ServerRoute getRoute(String id) {
    return _routes[id]!;
  }

  /// Returns Url With Given Route Path
  Uri getUri({String? routeId}) {
    String url = "";
    if (_host.isNotEmpty && _port >= 0) {
      url = _host + ":" + _port.toString();
    } else if (_host.isNotEmpty) {
      url = _host;
    }
    String route = "";
    if (routeId != null) {
      route = getRoute(routeId).getPath();
    }
    if (_isHttp) {
      return Uri.http(url, route);
    }
    return Uri.https(url, route);
  }

  /// Returns Server Id
  String getId() {
    return _id;
  }

  /// Return Server Cookies
  CookieHandler getCookieHandler() {
    return _cookieHandler;
  }
}

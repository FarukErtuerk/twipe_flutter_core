import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'faker/network_faker.dart';
import 'faker/network_faker_request.dart';
import 'network_result.dart';
import 'server/server.dart';
import 'server/server_route.dart';

/// Main Network Class.
/// You Should Create A Subclass Extending This Class
abstract class Network {
  @protected
  final String _id;

  static Map<String, dynamic> _networks = {};

  /// List of Servers in this Network
  Map<String, Server> _server = {};

  Network(this._id) {
    _networks[_id] = this;
  }

  static T of<T>(String id) {
    return _networks[id] as T;
  }

  /// Adds Server To Network
  void addServer(Server server) {
    _server[server.getId()] = server;
  }

  Server getServer(String id) {
    return _server[id]!;
  }

  /// Returns Network Id
  String getId() {
    return _id;
  }

  /// This Is Your Request Interface
  /// You can change the way you are sending a request to the server
  Future<NetworkResult> call(String serverId, String routeId,
      {int requestType = NetworkRequestType.POST,
      Map<String, dynamic>? data,
      Map<String, String>? replacements,
      Map<String, dynamic>? headers}) async {
    Server server = getServer(serverId);
    Uri uri = server.getUri(routeId: routeId, replacements: replacements);
    ServerRoute serverRoute = server.getRoute(routeId);
    return await _callServer(
        server, serverRoute, uri, requestType, data, headers);
  }

  /// This Is The Actual Network Request
  /// It transforms your response into readable String element
  /// Server Cookies will be saved into your Cache and can be accessed later
  @protected
  Future<NetworkResult> _callServer(
      Server server,
      ServerRoute serverRoute,
      Uri uri,
      int requestType,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers) async {
    /// Check if NetworkFaker contains Route.
    if (NetworkFaker.hasRoute(serverRoute.getId())) {
      return await NetworkFaker.getRoute(serverRoute.getId()).callback(
          NetworkFakerRequest(server, serverRoute, data, requestType, uri));
    }

    String result = "";
    HttpClient client = new HttpClient();

    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    /// Creates the actual Network Request.
    HttpClientRequest request = await client.postUrl(uri);

    if (requestType == NetworkRequestType.GET) {
      request = await client.getUrl(uri);
    } else if (requestType == NetworkRequestType.HEAD) {
      request = await client.headUrl(uri);
    } else if (requestType == NetworkRequestType.PUT) {
      request = await client.putUrl(uri);
    }
    String cookies = server.getCookieHandler().convertCookiesToString();
    if (cookies.isNotEmpty) {
      request.headers.add(HttpHeaders.cookieHeader, cookies);
    }

    /// Add Server Default Headers
    if (server.getDefaultHeader().isNotEmpty) {
      for (String key in server.getDefaultHeader().keys) {
        request.headers.add(key, server.getDefaultHeader()[key]);
      }
    }

    /// Add Server Route Default Headers
    if (serverRoute.getDefaultHeader().isNotEmpty) {
      for (String key in serverRoute.getDefaultHeader().keys) {
        request.headers.add(key, serverRoute.getDefaultHeader()[key]);
      }
    }

    if (headers != null) {
      for (String headerKey in headers.keys) {
        request.headers.add(headerKey, headers[headerKey]);
      }
    }

    /// Add Server Default Body
    if (server.getDefaultBody().isNotEmpty) {
      if (data == null) {
        data = {};
      }
      data.addAll(server.getDefaultBody());
    }

    /// Add Server Route Default Body
    if (serverRoute.getDefaultBody().isNotEmpty) {
      if (data == null) {
        data = {};
      }
      data.addAll(serverRoute.getDefaultBody());
    }
    if (data != null) {
      request.add(utf8.encode(json.encode(data)));
    }

    /// Do Server Request
    HttpClientResponse response = await request.close();

    /// Update Server Cookies
    await server.getCookieHandler().updateCookies(response.headers);

    /// Process Data
    result = await response.transform(utf8.decoder).join();
    return NetworkResult.build(result, response);
  }
}

abstract class NetworkRequestType {
  static const int GET = 0;
  static const int POST = 1;
  static const int HEAD = 2;
  static const int PUT = 3;
}

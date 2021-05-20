import 'dart:io';

import 'package:flutter/foundation.dart';
import '../../cache/cache_handler.dart';
import '../../cache/cache_object.dart';

class CookieHandler {
  /// Cookie Handler Id
  @protected
  final String _id;

  /// Server Cookies
  @protected
  Map<String, Cookie> _cookies = {};

  CookieHandler(this._id);

  /// Return Cookies
  Map<String, Cookie> getCookies() {
    return _cookies;
  }

  /// Clear Cookie Cache
  Future<bool> clear() async {
    return await CacheHandler.removeCacheObject("server_" + _id + "_cookies");
  }

  String convertCookiesToString() {
    String cookies = "";
    for (String key in getCookies().keys) {
      cookies += getCookies()[key]!.name + "=" + getCookies()[key]!.value + ";";
    }
    return cookies;
  }

  Future<void> loadCookies() async {
    List<CacheObject> cache =
        await CacheHandler.getCacheList("server_" + _id + "_cookies");
    for (CacheObject cacheObject in cache) {
      _cookies[cacheObject.getData()["id"]] = new Cookie(
          cacheObject.getData()["id"], cacheObject.getData()["value"]);
    }
  }

  Future<void> updateCookies(HttpHeaders headers) async {
    List<String>? cookies = headers["set-cookie"];
    if (cookies != null) {
      for (String cookie in cookies) {
        Cookie cookieInstance = Cookie.fromSetCookieValue(cookie);
        await CacheHandler.saveCacheObjectToList(
            "server_" + _id + "_cookies",
            CacheObject(
                {"id": cookieInstance.name, "value": cookieInstance.value}),
            "id");
        _cookies[cookieInstance.name] = cookieInstance;
      }
    }
  }
}

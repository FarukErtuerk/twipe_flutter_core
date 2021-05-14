import 'dart:convert';
import 'package:twipe_flutter_core/utils/config/environment_handler.dart';
import 'package:twipe_flutter_core/utils/encryption/dencode.dart';

import 'cache_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHandler {
  /// Clears Cache
  static Future<bool> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }

  /// Get Cache Object from List<CacheObject> with value
  static Future<CacheObject?> getCacheObjectFromList(
      String key, String objectKey, String objectKeyValue,
      {bool deleteOnError = true}) async {
    List<CacheObject> cache =
        await getCacheList(key, deleteOnError: deleteOnError);
    for (CacheObject cacheObject in cache) {
      if (cacheObject.data[objectKey] == objectKeyValue) {
        return cacheObject;
      }
    }
    return null;
  }

  /// Get Cache List
  static Future<List<CacheObject>> getCacheList(String key,
      {bool deleteOnError = true}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        List<String> values = sharedPreferences.getStringList(key)!;
        List<CacheObject> result = [];
        values.forEach((element) {
          Map<dynamic, dynamic> data = jsonDecode(_reApplyCacheKey(element));
          result.add(CacheObject(data.cast()));
        });
        return result;
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Cannot Delete Key: " + key);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.containsKey(key)) {
          await sharedPreferences.remove(key);
        }
      }
      print(e);
    }
    return [];
  }

  /// Get Cache Object from List
  static Future<CacheObject?> getCacheObject(String key,
      {bool deleteOnError = true}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        String value = sharedPreferences.getString(key)!;
        Map<dynamic, dynamic> data = jsonDecode(_reApplyCacheKey(value));
        return CacheObject(data.cast());
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Cannot Delete Key: " + key);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.containsKey(key)) {
          await sharedPreferences.remove(key);
        }
      }
      print(e);
    }
    return null;
  }

  /// Save CacheObject to Cache
  static Future<bool> saveCacheObject(String key, CacheObject cacheObject,
      {bool overwrite = true, bool deleteOnError = true}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (!sharedPreferences.containsKey(key) || overwrite) {
        if (await sharedPreferences.setString(
            key, _applyCacheKey(jsonEncode(cacheObject.data)))) {
          return true;
        }
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Cannot Delete Key: " + key);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.containsKey(key)) {
          await sharedPreferences.remove(key);
        }
      }
      print(e);
    }

    return false;
  }

  /// Remove Cache Object From Cache
  static Future<bool> removeCacheObject(String key) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return await sharedPreferences.remove(key);
    } catch (e) {}
    return false;
  }

  static Future<bool> saveCacheObjectToList(
      String key, CacheObject cacheObject, String keyField,
      {bool overwrite = true, bool deleteOnError = true, int? limit}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        List<String> values = sharedPreferences.getStringList(key)!;
        List<String> newValues = [];
        bool foundInOld = false;
        values.forEach((element) {
          if (jsonDecode(_reApplyCacheKey(element))[keyField] ==
              cacheObject.data[keyField]) {
            foundInOld = true;
            if (overwrite) {
              newValues.add(_applyCacheKey(jsonEncode(cacheObject.data)));
            } else {
              newValues.add(element);
            }
          } else {
            newValues.add(element);
          }
        });
        if (!foundInOld) {
          newValues.add(_applyCacheKey(jsonEncode(cacheObject.data)));
        }
        if (limit != null && limit > 0) {
          while (newValues.length > limit) {
            newValues.removeAt(0);
          }
        }
        await sharedPreferences.setStringList(key, newValues);
        return true;
      } else {
        if (await sharedPreferences.setStringList(
            key, [_applyCacheKey(jsonEncode(cacheObject.data))])) {
          return true;
        }
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Cannot Delete Key: " + key);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.containsKey(key)) {
          await sharedPreferences.remove(key);
        }
      }
      print(e);
    }
    return false;
  }

  /// Remove CacheObject from List<CacheObject>
  static Future<bool> removeCacheObjectFromList(
      String key, String objectId, String keyField,
      {bool deleteOnError = true}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        List<String> values = sharedPreferences.getStringList(key)!;
        List<String> newValues = [];
        values.forEach((element) {
          if (jsonDecode(_reApplyCacheKey(element))[keyField] != objectId) {
            newValues.add(element);
          }
        });
        await sharedPreferences.setStringList(key, newValues);
        return true;
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Cannot Delete Key: " + key);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (sharedPreferences.containsKey(key)) {
          await sharedPreferences.remove(key);
        }
      }
      print(e);
    }
    return false;
  }

  static String _reApplyCacheKey(String value) {
    return DEncode.decode(
        EnvironmentHandler.getStringValue("CACHE_KEY", defaultValue: ""),
        value);
  }

  static String _applyCacheKey(String value) {
    return DEncode.encode(
        EnvironmentHandler.getStringValue("CACHE_KEY", defaultValue: ""),
        value);
  }
}

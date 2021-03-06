import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/config/environment.dart';
import '../../utils/encryption/crypt.dart';
import 'cache_object.dart';

class CacheHandler {
  static SharedPreferences? sharedPreferences;
  static Future<void> setup() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences getSharedPreferences() {
    return sharedPreferences!;
  }

  static bool isSetup() {
    return sharedPreferences != null;
  }

  /// Clear current Cache
  static Future<bool> clear() async {
    return await getSharedPreferences().clear();
  }

  /// Get `CacheObject` from List<CacheObject> with value
  static Future<CacheObject?> getCacheObjectFromList(
      String key, String objectKey, String objectKeyValue,
      {bool deleteOnError = true}) async {
    List<CacheObject> cache =
        await getCacheList(key, deleteOnError: deleteOnError);
    for (CacheObject cacheObject in cache) {
      if (cacheObject.getData()[objectKey] == objectKeyValue) {
        return cacheObject;
      }
    }
    return null;
  }

  /// Get `List<CacheObject>`
  static Future<List<CacheObject>> getCacheList(String key,
      {bool deleteOnError = true}) async {
    try {
      if (getSharedPreferences().containsKey(key)) {
        List<String> values = getSharedPreferences().getStringList(key)!;
        List<CacheObject> result = [];
        values.forEach((element) {
          Map<dynamic, dynamic> data = jsonDecode(_reApplyCacheKey(element));
          result.add(CacheObject(data.cast()));
        });
        return result;
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Delete Key " + key);
        await removeCacheObject(key);
      }
      print(e);
    }
    return [];
  }

  /// Get Cache Object from List
  static Future<CacheObject?> getCacheObject(String key,
      {bool deleteOnError = true}) async {
    try {
      if (getSharedPreferences().containsKey(key)) {
        String value = getSharedPreferences().getString(key)!;
        Map<dynamic, dynamic> data = jsonDecode(_reApplyCacheKey(value));
        return CacheObject(data.cast());
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Delete Key: " + key);
        await removeCacheObject(key);
      }
      print(e);
    }
    return null;
  }

  /// Save CacheObject to Cache
  static Future<bool> saveCacheObject(String key, CacheObject cacheObject,
      {bool overwrite = true, bool deleteOnError = true}) async {
    try {
      if (!getSharedPreferences().containsKey(key) || overwrite) {
        if (await getSharedPreferences().setString(
            key, _applyCacheKey(jsonEncode(cacheObject.getData())))) {
          return true;
        }
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Delete Key: " + key);
        await removeCacheObject(key);
      }
      print(e);
    }

    return false;
  }

  /// Remove Cache Object From Cache
  static Future<bool> removeCacheObject(String key) async {
    try {
      return await getSharedPreferences().remove(key);
    } catch (e) {}
    return false;
  }

  static Future<bool> saveCacheObjectToList(
      String key, CacheObject cacheObject, String keyField,
      {bool overwrite = true, bool deleteOnError = true, int? limit}) async {
    try {
      if (getSharedPreferences().containsKey(key)) {
        List<String> values = getSharedPreferences().getStringList(key)!;
        List<String> newValues = [];
        bool foundInOld = false;
        values.forEach((element) {
          if (jsonDecode(_reApplyCacheKey(element))[keyField] ==
              cacheObject.getData()[keyField]) {
            foundInOld = true;
            if (overwrite) {
              newValues.add(_applyCacheKey(jsonEncode(cacheObject.getData())));
            } else {
              newValues.add(element);
            }
          } else {
            newValues.add(element);
          }
        });
        if (!foundInOld) {
          newValues.add(_applyCacheKey(jsonEncode(cacheObject.getData())));
        }
        if (limit != null && limit > 0) {
          while (newValues.length > limit) {
            newValues.removeAt(0);
          }
        }
        await getSharedPreferences().setStringList(key, newValues);
        return true;
      } else {
        if (await getSharedPreferences().setStringList(
            key, [_applyCacheKey(jsonEncode(cacheObject.getData()))])) {
          return true;
        }
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Delete Key: " + key);
        await removeCacheObject(key);
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
      if (getSharedPreferences().containsKey(key)) {
        List<String> values = getSharedPreferences().getStringList(key)!;
        List<String> newValues = [];
        values.forEach((element) {
          if (jsonDecode(_reApplyCacheKey(element))[keyField] != objectId) {
            newValues.add(element);
          }
        });
        await getSharedPreferences().setStringList(key, newValues);
        return true;
      }
    } catch (e) {
      if (deleteOnError) {
        print("CacheHandler: Delete Key: " + key);
        await removeCacheObject(key);
      }
      print(e);
    }
    return false;
  }

  static String _reApplyCacheKey(String value) {
    return Crypt.decrypt(
        Environment.getStringValue("CACHE_KEY", defaultValue: ""), value);
  }

  static String _applyCacheKey(String value) {
    return Crypt.encrypt(
        Environment.getStringValue("CACHE_KEY", defaultValue: ""), value);
  }
}

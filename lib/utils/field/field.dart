/// Default Field parser
class Field {
  /// Parse Bool
  static bool getBool(dynamic data, bool defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    if (data.toString().isEmpty) {
      return defaultValue;
    }
    if (data.toString().toLowerCase() == "false") {
      return false;
    }
    if (data.toString().toLowerCase() == "true") {
      return true;
    }
    return defaultValue;
  }

  /// Parse String
  static String getString(dynamic data, String defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    return data.toString();
  }

  /// Parse Integer
  static int getInt(dynamic data, int defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    return int.parse(data.toString());
  }

  /// Parse double
  static double getDouble(dynamic data, double defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    return double.parse(data.toString());
  }

// Parse Map String dynamic
  static Map<String, dynamic> parseMapStringDynamic(
      dynamic data, Map<String, dynamic> defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    try {
      Map<String, dynamic> map = data.cast<String, dynamic>();
      return map;
    } catch (e) {
      return defaultValue;
    }
  }

// Parse Map
  static Map<K, T> parseMapCustom<K, T>(dynamic data, Map<K, T> defaultValue) {
    if (data == null) {
      return defaultValue;
    }
    try {
      Map<K, T> map = data.cast<K, T>();
      return map;
    } catch (e) {
      return defaultValue;
    }
  }
}

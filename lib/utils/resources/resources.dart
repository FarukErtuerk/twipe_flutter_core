class Resources {
  /// Returns resources/style/`path`.json
  static String getStylePath(String path) {
    return 'resources/style/' + path + ".json";
  }

  /// Returns resources/json/`path`/.json
  static String getJSONPath(String path) {
    return 'resources/json/' + path + ".json";
  }

  /// Returns resources/`path`
  static String getResourcePath(String path) {
    return 'resources/' + path;
  }

  /// Returns Image Path: resources/images/`path`
  static String getImagePath(String path) {
    return 'resources/images/' + path;
  }
}

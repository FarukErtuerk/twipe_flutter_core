class Resources {
  static String getStylePath(String filePath) {
    return 'resources/style/' + filePath + ".json";
  }

  static String getJSONPath(String filePath) {
    return 'resources/json/' + filePath + ".json";
  }

  static String getResource(String filePath) {
    return 'resources/' + filePath;
  }
}

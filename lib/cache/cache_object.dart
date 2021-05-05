/// Cache Object class to Handle Data
class CacheObject {
  Map<String, dynamic> data;

  CacheObject(this.data);

  /// CacheObject has Data
  bool hasData() {
    return data.isNotEmpty;
  }
}

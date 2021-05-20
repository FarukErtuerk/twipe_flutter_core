/// Cache Object class to Handle Data
class CacheObject {
  final Map<String, dynamic> _data;

  CacheObject(this._data);

  /// CacheObject has Data
  bool hasData() {
    return _data.isNotEmpty;
  }

  Map<String, dynamic> getData() {
    return _data;
  }
}

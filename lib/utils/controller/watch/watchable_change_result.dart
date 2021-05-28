class WatchableChangeResult {
  final dynamic _data;
  WatchableChangeResult(this._data);

  bool hasData() {
    return _data != null;
  }

  dynamic getData() {
    return _data;
  }
}

class WatchableChangeResult {
  final dynamic _data;
  final bool _done;
  WatchableChangeResult(this._done, this._data);

  factory WatchableChangeResult.error({dynamic data}) {
    return WatchableChangeResult(false, data);
  }

  factory WatchableChangeResult.done({dynamic data}) {
    return WatchableChangeResult(true, data);
  }

  bool isDone() {
    return _done;
  }

  bool hasData() {
    return _data != null;
  }

  dynamic getData() {
    return _data;
  }
}

class WatchableChangeAction {
  final String watchableId;
  final dynamic _data;
  WatchableChangeAction(this.watchableId, this._data);

  bool hasData() {
    return _data != null;
  }

  dynamic getData() {
    return _data;
  }
}

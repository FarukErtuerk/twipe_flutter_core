class WatchableChangeAction {
  final String watchableId;
  final dynamic eventData;
  WatchableChangeAction(this.watchableId, this.eventData);

  bool hasEventData() {
    return eventData != null;
  }
}

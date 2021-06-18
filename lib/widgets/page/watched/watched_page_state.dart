import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'watched_page.dart';

/* WatchedPageState with watchable */
abstract class WatchedPageState<T extends WatchedPage> extends State<T>
    with Watchable {
  @protected
  bool _isLoading = false;

  /// Is Page Loading?
  bool isLoading() {
    return _isLoading;
  }

  /// sets `_isLoading` and calls `setState((){})`
  void setLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  @override
  @mustCallSuper
  Future<dynamic> onChanged(WatchableChangeResult watchableChangeResult) async {
    if (mounted) {
      setState(() {});
    }
    return null;
  }
}

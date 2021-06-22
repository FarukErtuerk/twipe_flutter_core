import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable_change_result.dart';
import 'watched_page.dart';

/* WatchedPageState with watchable */
abstract class WatchedLoadablePageState<T extends WatchedPage> extends State<T>
    with Watchable, SingleTickerProviderStateMixin {
  AnimationController? _loadingAnimationController;
  Animation? _loadingAnimation;

  int loadingAnimationDuration = 2;

  double loadingAnimationBegin = 0.0;

  double loadingAnimationEnd = 12.0;

  bool loadingAnimationReverse = true;

  AnimationController getLoadingAnimationController() {
    return _loadingAnimationController!;
  }

  Animation getLoadingAnimation() {
    return _loadingAnimation!;
  }

  bool useLoadableAnimation = true;

  @override
  void initState() {
    if (useLoadableAnimation) {
      _loadingAnimationController = AnimationController(
          vsync: this, duration: Duration(seconds: loadingAnimationDuration));
      _loadingAnimation =
          Tween(begin: loadingAnimationBegin, end: loadingAnimationEnd).animate(
        CurvedAnimation(
            parent: _loadingAnimationController!, curve: Curves.easeOut),
      );
      _loadingAnimationController!.repeat(reverse: loadingAnimationReverse);
    }
    super.initState();
  }

  @protected
  bool _isLoading = false;

  /// Is Page Loading?
  bool isLoading() {
    return _isLoading;
  }

  /// sets `_isLoading` and calls `setState((){})`
  void setLoading(bool value, {bool updateState = true}) {
    _isLoading = value;
    if (updateState && mounted) {
      setState(() {});
    }
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

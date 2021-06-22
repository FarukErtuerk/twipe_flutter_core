import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_loadable_page_state.dart';

abstract class LoadableWidget extends StatelessWidget {
  final WatchedLoadablePageState _watchedLoadablePageState;
  final dynamic value;
  LoadableWidget(this._watchedLoadablePageState, this.value);

  ///LoadableWidget has Value
  bool hasValue() {
    return value != null;
  }

  /// Get Animation Controller
  AnimationController getAnimationController() {
    return _watchedLoadablePageState.getLoadingAnimationController();
  }

  /// Get Animation
  Animation getAnimation() {
    return _watchedLoadablePageState.getLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return hasValue()
        ? buildLoaded(context)
        : AnimatedBuilder(
            animation: getAnimation(),
            builder: (context, _) {
              return buildLoading(context);
            },
          );
  }

  /// Build Widget in Loading State
  Widget buildLoading(BuildContext context);

  /// Build Widget if Loaded
  Widget buildLoaded(BuildContext context);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_page_state.dart';

abstract class LoadableWidget extends StatelessWidget {
  final WatchedPageState _watchedPageState;
  final dynamic value;
  LoadableWidget(this._watchedPageState, this.value);
  bool hasValue() {
    return value != null;
  }

  AnimationController getAnimationController() {
    return _watchedPageState.getLoadingAnimationController();
  }

  Animation getAnimation() {
    return _watchedPageState.getLoadingAnimation();
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

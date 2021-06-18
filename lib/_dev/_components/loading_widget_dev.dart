import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';
import 'package:twipe_flutter_core/widgets/loadable/components/pulsing_circle.dart';
import 'package:twipe_flutter_core/widgets/loadable/components/pulsing_line.dart';
import 'package:twipe_flutter_core/widgets/loadable/loadable_widget.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_page_state.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_page.dart';

class LoadingWidgetDev extends LoadableWidget {
  LoadingWidgetDev(
      WatchedPageState<WatchedPage> watchedPageState, dynamic value)
      : super(watchedPageState, value);

  @override
  Widget buildLoaded(BuildContext context) {
    return Container();
  }

  @override
  Widget buildLoading(BuildContext context) {
    return ListTile(
      title: PulsingLine(
        this,
        width: 2,
        heigth: 10,
        valueColor: HexColor.fromHex('#D8E1E9'),
        backgroundColor: HexColor.fromHex('#B3C5D7'),
      ),
      subtitle: PulsingLine(
        this,
        width: 2,
        heigth: 10,
        valueColor: HexColor.fromHex('#D8E1E9'),
        backgroundColor: HexColor.fromHex('#B3C5D7'),
      ),
      leading: PulsingCircle(
        this,
        40,
        valueColor: HexColor.fromHex('#D8E1E9'),
        backgroundColor: HexColor.fromHex('#B3C5D7'),
      ),
    );
  }
}

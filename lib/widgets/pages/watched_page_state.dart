import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/controller/watch/watchable.dart';
import 'watched_page.dart';

abstract class WatchedPageState<T extends WatchedPage> extends State<T>
    with Watchable {}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_page.dart';
import 'package:twipe_flutter_core/widgets/page/watched/watched_page_state.dart';

class MainPage extends WatchedPage {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends WatchedPageState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [],
        ),
        padding: EdgeInsets.all(32),
      )),
    );
  }

  @override
  String get watchableId => "main_page";

  @override
  String get watcherId => "main_page_watcher";
}

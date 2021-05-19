import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/_dev/_pages/_main_page.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';

Future<void> main() async {
  await TwipeFlutterCore.initialize(configFilePath: 'resources/.env.example');
  runApp(DevApp());
}

class DevApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/utils/ui/color/hex_color.dart';

ThemeData lightTheme =
    ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.black);

Future<void> main() async {
  await initialize(configFilePath: ".env.example");
  runApp(_ExampleApp());
}

class _ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Twipe Flutter Example",
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: _ExampleMainPage());
  }
}

class _ExampleMainPage extends StatefulWidget {
  @override
  _ExampleMainPageState createState() => _ExampleMainPageState();
}

class _ExampleMainPageState extends State<_ExampleMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}

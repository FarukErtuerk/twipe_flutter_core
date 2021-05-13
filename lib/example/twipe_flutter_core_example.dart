import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/twipe_flutter_core.dart';
import 'package:twipe_flutter_core/ui/date/calendar_widget.dart';
import 'package:twipe_flutter_core/ui/gradient/gradient_text.dart';
import 'package:twipe_flutter_core/utils/ui/style/ui_text_style.dart';

Future<void> main() async {
  await initialize(configFilePath: ".env.example");
  runApp(_ExampleApp());
}

class _ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Twipe Library Example",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _ExamplePage(),
    );
  }
}

class _ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<_ExamplePage> {
  final _UI ui = _UI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Test",
              style: TextStyle(color: Colors.black),
            ),
            buildSection("Calendar Widget", CalendarWidget.build()),
            buildSection(
                "Gradient Text",
                GradientText("Hello World!", [Colors.blue, Colors.green],
                    ui.primaryTextStyle))
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, Widget child) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: ui.primaryTextStyle,
                )
              ],
            ),
          ),
          child
        ],
      ),
    );
  }
}

class _UI implements UITextStyle {
  @override
  TextStyle get accentTextStyle => TextStyle(fontSize: 20, color: Colors.black);

  @override
  TextStyle get primaryTextStyle =>
      TextStyle(fontSize: 20, color: Colors.black);

  @override
  TextStyle get secondaryTextStyle =>
      TextStyle(fontSize: 20, color: Colors.black);
}

library twipe_flutter_core;

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/config/environment_handler.dart';
import 'package:twipe_flutter_core/utils/json/json_handler.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';

/// Setup Twipe Library
/// Loads Environment Handler
class TwipeFlutterCore {
  static Future<void> initialize({String configFilePath = ".env"}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await EnvironmentHandler.setup(configFilePath: configFilePath);
    await JSONHandler.setup();
    await TwipeTheme.setup();
  }
}

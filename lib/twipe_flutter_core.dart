library twipe_flutter_core;

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';
import 'package:twipe_flutter_core/utils/config/environment.dart';
import 'package:twipe_flutter_core/utils/json/json_handler.dart';
import 'package:twipe_flutter_core/utils/resources/resources.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';

/// Setup Twipe Library
/// Loads Environment Handler
class TwipeFlutterCore {
  static Future<void> initialize({String? configFilePath}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Environment.setup(
        configFilePath: configFilePath ?? Resources.getResource('.env'));
    await JSONHandler.setup();
    Configuration();
    await TwipeTheme.setup();
  }
}

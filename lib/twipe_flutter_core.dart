library twipe_flutter_core;

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/config/environment_handler.dart';

/// Setup Twipe Library
/// Loads Environment Handler
Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentHandler.setup();
}

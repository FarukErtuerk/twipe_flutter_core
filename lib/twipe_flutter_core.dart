library twipe_flutter_core;

import 'package:flutter/material.dart';
import 'package:twipe_flutter_core/utils/config/configuration.dart';
import 'package:twipe_flutter_core/utils/config/environment.dart';
import 'package:twipe_flutter_core/utils/json/json_handler.dart';
import 'package:twipe_flutter_core/utils/network/network.dart';
import 'package:twipe_flutter_core/utils/resources/resources.dart';
import 'package:twipe_flutter_core/utils/ui/theme/twipe_theme.dart';

/// Setup Twipe Library
/// Loads Environment Handler
class TwipeFlutterCore {
  static Map<String, Network> _networks = {};

  static Future<void> initialize({String? configFilePath}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Environment.setup(
        configFilePath: configFilePath ?? Resources.getResource('.env'));
    await JSONHandler.setup();
    Configuration();
    await TwipeTheme.setup();
  }

  static void addNetwork(Network network) {
    _networks[network.getId()] = network;
  }

  static void removeNetwork(Network network) {
    if (_networks.containsKey(network.getId())) {
      _networks.remove(network.getId());
    }
  }

  static Network getNetwork(String networkId) {
    return _networks[networkId]!;
  }
}

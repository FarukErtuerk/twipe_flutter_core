import '../../cache/cache_handler.dart';
import '../../cache/cache_object.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';

import '../network_result.dart';

/// NetworkConfiguration class holds all your data from your Configuration file
/// You always should save your Configuration File in your Server because of Security Reasons
class NetworkConfig {
  final int _syncIntervall;
  final String _configId;
  Map<String, dynamic> _config = {};
  int _lastSync = 0;

  NetworkConfig(this._configId, this._syncIntervall);

  /// Synchronize Config Data with Server
  Future<bool> setupFromNetworkRequest(Future<NetworkResult> callback) async {
    await _loadFromCache();
    if (!shouldSync()) {
      return true;
    }
    try {
      NetworkResult networkResult = await callback;
      if (networkResult.hasError()) {
        return false;
      }
      if (!networkResult.hasData()) {
        return false;
      }
      Map<String, dynamic> result = networkResult.getData();
      _config = result;
      await saveConfig();
    } catch (e) {
      throw e;
    }
    return true;
  }

  /// Should Sync current Configuration File with Network
  bool shouldSync() {
    return ((DateTime.now().millisecondsSinceEpoch - _lastSync) >=
        _syncIntervall);
  }

  /// Clear Config from Cache
  Future<void> clear() async {
    await CacheHandler.removeCacheObject("network_config_" + _configId);
  }

  /// Save Config to Cache
  Future<void> saveConfig() async {
    CacheHandler.saveCacheObject("network_config_" + _configId,
        CacheObject({"lastSync": _lastSync, "config": _config}));
  }

  /// Load NetworkConfig From Cache
  Future<void> _loadFromCache() async {
    CacheObject? cacheObject =
        await CacheHandler.getCacheObject("network_config_" + _configId);
    if (cacheObject == null) {
      return;
    }
    _lastSync = Field.getInt(cacheObject.getData()["lastSync"], 0);
    _config = Field.parseMapStringDynamic(cacheObject.getData()["config"], {});
  }

  /// Returns Network Config
  Map<String, dynamic> getConfig() {
    return _config;
  }

  /// Returns Sync Intervall
  int getSyncInterval() {
    return _syncIntervall;
  }

  /// Returns Last Sync
  int getLastSync() {
    return _lastSync;
  }
}

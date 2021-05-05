import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Network Result Class
/// Expected Value:
/// {
///   status:done
///   data:value
/// }
class NetworkResult {
  /// Raw Data
  @protected
  final String? _rawData;

  /// Converted Data
  @protected
  Map<String, dynamic> _convertedData = {};

  NetworkResult(this._rawData) {
    if (_rawData != null) {
      _convertedData = jsonDecode(_rawData!);
    }
  }

  /// Network Result Has Data Body
  bool hasData() {
    if (!_convertedData.containsKey("data")) {
      return false;
    }
    return true;
  }

  /// Returns Network Result Data
  Map<String, dynamic> getData() {
    return _convertedData["data"];
  }

  /// Network Result Has Errors?
  bool hasError() {
    if (_rawData == null || _convertedData.isEmpty) {
      return true;
    }
    if (!_convertedData.containsKey("status")) {
      return true;
    }
    if (_convertedData["status"] != "done") {
      return true;
    }
    return false;
  }

  /// Network Result Is Safe?
  bool isDone() {
    if (!_convertedData.containsKey("status")) {
      return false;
    }
    if (_convertedData["status"] != "done") {
      return false;
    }
    return true;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Network Result Class
/// Expected Value:
/// {
///   status:done
///   data:value
/// }
class NetworkResult {
  static final String done = 'done';

  /// Raw Data
  @protected
  final String? _rawData;

  final HttpClientResponse? _response;

  /// Converted Data
  @protected
  Map<String, dynamic> _convertedData = {};

  @protected
  NetworkResult(this._rawData, this._response) {
    if (_rawData != null) {
      _convertedData = jsonDecode(_rawData!);
    }
  }

  factory NetworkResult.fromFaker(String? rawData) {
    return NetworkResult(rawData, null);
  }

  factory NetworkResult.build(String? rawData, HttpClientResponse response) {
    return NetworkResult(rawData, response);
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
    if (_convertedData["status"] != done) {
      return true;
    }
    return false;
  }

  /// Returns Network Result Status
  String getStatus() {
    return _convertedData["status"];
  }

  /// Network Result Is Safe?
  bool isDone() {
    if (!_convertedData.containsKey("status")) {
      return false;
    }
    if (_convertedData["status"] != done) {
      return false;
    }
    return true;
  }

  bool hasResponse() {
    return _response != null;
  }

  HttpClientResponse getResponse() {
    return _response!;
  }
}

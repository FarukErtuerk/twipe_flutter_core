import 'package:twipe_flutter_core/utils/json/json_object.dart';

/// Cache Object class to Handle Data
class CacheObject extends JSONObject {
  final Map<String, dynamic> _data;

  CacheObject(this._data) : super(_data);

  /// CacheObject has Data
  bool hasData() {
    return _data.isNotEmpty;
  }

  Map<String, dynamic> getData() {
    return _data;
  }

  @override
  List<String> get validator => [];
}

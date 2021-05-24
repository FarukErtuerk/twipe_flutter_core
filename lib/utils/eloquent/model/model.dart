import 'package:flutter/foundation.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/json/json_object.dart';
import '../../cache/cache_object.dart';
import '../../cache/cacheable.dart';

/// Model class handles your Data
abstract class Model extends JSONObject with Cacheable {
  /// You can define your hidden fields here and trim them when requesting Model Data
  @protected
  List<String> get hiddenFields;

  /// Do Not Edit this, except you know what you are doing
  @protected
  final List<String> baseFields = ["id", "created_at", "updated_at"];

  /// Model Id
  @protected
  String? _id;

  /// Model Constructor
  Model(Map<String, dynamic> data) : super(data) {
    if (!data.containsKey("id")) {
      throw UnsupportedError("Model Requires Field :id");
    }
    this._id = Field.getString(data["id"], "");

    if (this._id!.isEmpty) {
      throw UnsupportedError("Model Requires Field :id");
    }
  }

  /// Validates Model Data
  bool validate() {
    if (!validateJSON()) {
      return false;
    }
    if (!Field.validateFields(baseFields, getData())) {
      return false;
    }
    return true;
  }

  /// Returns Model Data With Options
  Map<String, dynamic> getModelData({bool applyHiddenFields = false}) {
    if (applyHiddenFields) {
      Map<String, dynamic> tmp = getData();
      for (String key in hiddenFields) {
        tmp.remove(key);
      }
      return tmp;
    }
    return getData();
  }

  /// Return Model id
  String getId() {
    return _id!;
  }

  /// Returns Creation Date
  int getCreatedAt() {
    return int.parse(getData()["created_at"].toString());
  }

  /// Returns Update Date
  int getUpdatedAt() {
    return int.parse(getData()["updated_at"].toString());
  }

  @override
  CacheObject toCacheObject() {
    return CacheObject(getModelData());
  }
}

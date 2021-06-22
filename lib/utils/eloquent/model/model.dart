import 'package:flutter/foundation.dart';
import 'package:twipe_flutter_core/utils/field/field.dart';
import 'package:twipe_flutter_core/utils/field/field_validator.dart';
import 'package:twipe_flutter_core/utils/json/json_object.dart';
import '../../cache/cache_object.dart';
import '../../cache/cacheable.dart';

/// Model class handles your Data
abstract class Model extends JSONObject with Cacheable {
  /// You can define your hidden fields here and trim them when requesting Model Data
  @protected
  List<String> get hiddenFields;

  /// Not remove `id` ad least.
  @protected
  final List<String> baseFields = [
    "id=required",
    "created_at=required",
    "updated_at=required"
  ];

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

  @override
  bool validate({List<String>? optionalValidator}) {
    return super.validate(optionalValidator: optionalValidator) &&
        FieldValidator.validate(baseFields, getData());
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

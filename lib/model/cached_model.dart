import 'model.dart';

/// CacheModel
class CachedModel extends Model {
  CachedModel(Map<String, dynamic> modelData) : super(modelData);

  @override
  List<String> get hiddenFields => [];

  @override
  List<String> get requiredFields => [];
}

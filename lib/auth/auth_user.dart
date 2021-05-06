import '../model/model.dart';

/// AuthUser class provides you a complete Model
class AuthUser extends Model {
  AuthUser(Map<String, dynamic> modelData) : super(modelData);

  @override
  List<String> get hiddenFields => ["password", "email", "token"];

  @override
  List<String> get requiredFields => ["password", "email", "token"];

  /// Returns Auth Password
  String getPassword() {
    return getModelData()["password"];
  }

  /// Returns Auth Email
  String getEmail() {
    return getModelData()["email"];
  }

  /// Returns Auth Token
  String getToken() {
    return getModelData()["token"];
  }
}

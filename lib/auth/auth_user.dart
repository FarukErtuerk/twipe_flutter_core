import '../model/model.dart';

/// AuthUser class provides you a complete Model
class AuthUser extends Model {
  AuthUser(Map<String, dynamic> modelData) : super(modelData);

  @override
  List<String> get hiddenFields =>
      ["password", "email", "token", "phone_number"];

  @override
  List<String> get requiredFields =>
      ["password", "email|phone_number", "token"];

  /// Returns Auth Password
  String getPassword() {
    return getModelData()["password"];
  }

  /// Returns Auth Email
  String getEmail() {
    return getModelData()["email"];
  }

  /// Returns Auth Phone Number
  String getPhoneNumber() {
    return getModelData()["phone_number"];
  }

  /// Returns Auth Token
  String getToken() {
    return getModelData()["token"];
  }
}

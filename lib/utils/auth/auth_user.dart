import '../eloquent/model/model.dart';

/// AuthUser class provides you a complete Model
class AuthUser extends Model {
  AuthUser(Map<String, dynamic> modelData) : super(modelData);

  @override
  List<String> get hiddenFields =>
      ["email", "password", "phone_number", "token"];

  @override
  List<String> get validator => [
        "email=required&&max:255",
        "password=required&&min:8&&max255",
        "phone_number=required&&max:15",
        "token=required"
      ];

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

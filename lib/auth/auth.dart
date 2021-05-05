import '../collection/collection.dart';
import 'auth_user.dart';

/// Auth class. Use this for signing in or signing up in your Cloud Services or whatever
class Auth extends Collection<AuthUser> {
  Auth(String id) : super(id);

  /// AuthUser Models
  Map<String, AuthUser> _authUsers = {};

  /// Creates AuthUser From Model Data
  @override
  AuthUser? createModel(Map<String, dynamic> modelData) {
    AuthUser result = AuthUser(modelData);
    if (!result.validate()) {
      return null;
    }
    return result;
  }

  /// Returns all Authenticated Users
  Map<String, AuthUser> getAuthUsers() {
    return _authUsers;
  }

  /// Returns Auth User by Id
  AuthUser getAuthUser(String id) {
    return _authUsers[id]!;
  }

  /// Loads all AuthUsers
  @override
  Future<void> setup() async {
    List<Map<String, dynamic>> cache = await loadModelDataFromCache();
    Map<String, AuthUser> result = {};
    for (Map<String, dynamic> map in cache) {
      AuthUser? authUser = createModel(map);
      if (authUser != null && authUser.validate()) {
        result[authUser.getId()] = authUser;
      }
    }
    _authUsers = result;
  }
}

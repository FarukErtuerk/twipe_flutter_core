import 'package:twipe_flutter_core/model/cached_model.dart';

import '../collection/collection.dart';
import 'auth_user.dart';

/// Auth class. Use this for signing in or signing up in your Cloud Services or whatever
class Auth extends Collection<AuthUser> {
  Auth(String authenticatorId) : super(authenticatorId);

  /// Creates AuthUser From Model Data
  @override
  AuthUser? createModel(Map<String, dynamic> modelData) {
    AuthUser result = AuthUser(modelData);
    if (!result.validate()) {
      return null;
    }
    return result;
  }

  /// Loads all AuthUsers
  @override
  Future<void> setup() async {
    List<CachedModel> cache = await loadModelDataFromCache();
    Map<String, AuthUser> result = {};
    for (CachedModel model in cache) {
      AuthUser? authUser = createModel(model.getModelData());
      if (authUser != null && authUser.validate()) {
        result[authUser.getId()] = authUser;
      }
    }
    setModels(result);
  }
}

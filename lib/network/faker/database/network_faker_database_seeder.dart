import 'package:twipe_flutter_core/model/model.dart';
import 'package:twipe_flutter_core/network/faker/database/network_faker_database.dart';

class NetworkFakerDatabaseSeeder {
  static Map<String, Model> _toSeed = {};

  static void add(Model model) {
    _toSeed[model.getId()] = model;
  }

  static Future<void> clear(List<String> databases) async {
    for (String database in databases) {
      await NetworkFakerDatabase(database).clear();
    }
  }

  static Future<void> refresh(List<String> databases) async {
    await clear(databases);
    await seed();
  }

  static Future<void> seed() async {
    for (String key in _toSeed.keys) {
      await NetworkFakerDatabase(key).saveModel(_toSeed[key]!);
    }
    _toSeed.clear();
  }
}

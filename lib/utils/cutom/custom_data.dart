import 'dart:math';

class CustomData {
  static final List<String> names = [
    "Cleo",
    "Jhon",
    "Paul",
    "Greg",
    "Antonio",
    "Max",
    "Alex",
    "Leon",
    "Justin",
    "Angelina"
  ];

  static String getName() {
    return getRandomFromList(names);
  }

  static dynamic getRandomFromList(List<dynamic> list) {
    return list[Random().nextInt(list.length)];
  }

  static int getInt() {
    return Random().nextDouble().toInt();
  }

  static double getDouble() {
    return Random().nextDouble();
  }

  static bool getBool() {
    return Random().nextBool();
  }

  static DateTime getDateTimePast() {
    return DateTime.now()
        .subtract(Duration(minutes: Random().nextInt(100000), hours: 1));
  }

  static DateTime getDateTimeFuture() {
    return DateTime.now()
        .subtract(Duration(minutes: Random().nextInt(100000), hours: 1));
  }
}

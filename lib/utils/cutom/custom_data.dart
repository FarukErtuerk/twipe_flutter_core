import 'dart:math';

class CustomData {
  final List<String> names = [
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

  String getName() {
    return getRandomFromList(names);
  }

  dynamic getRandomFromList(List<dynamic> list) {
    return list[Random().nextInt(list.length)];
  }

  int getInt() {
    return Random().nextInt(double.infinity.toInt());
  }

  double getDouble() {
    return Random().nextDouble();
  }

  bool getBool() {
    return Random().nextBool();
  }

  DateTime getDateTimePast() {
    return DateTime.now()
        .subtract(Duration(minutes: Random().nextInt(100000), hours: 1));
  }

  DateTime getDateTimeFuture() {
    return DateTime.now()
        .subtract(Duration(minutes: Random().nextInt(100000), hours: 1));
  }
}

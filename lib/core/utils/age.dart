abstract class Age {
  const Age._();

  static int from(DateTime date) {
    final DateTime today = DateTime.now();

    int age = today.year - date.year;
    if (today.month < date.month) {
      age--;
    } else if (today.month == date.month && today.day < date.day) {
      age--;
    }

    return age;
  }

  static int fromMilliseconds(int milliseconds) {
    return from(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }

  static int fromMicroseconds(int microseconds) {
    return from(DateTime.fromMicrosecondsSinceEpoch(microseconds));
  }
}

import 'package:flutter/foundation.dart';

class Holiday {
  DateTime date;
  String name;
  bool active;

  Holiday({
    required this.date,
    required this.name,
    this.active = true,
  });
}

class HolidaysProvider with ChangeNotifier {
  List<Holiday> holidays = [];
}

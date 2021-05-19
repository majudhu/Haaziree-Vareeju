import 'package:flutter/foundation.dart';

class Staff {
  int staffId;
  String name;
  List<Shift> shifts = [];
  List<DateTime> offDays = [];

  Staff({required this.staffId, required this.name});
}

class StaffsProvider with ChangeNotifier {
  List<Staff> staffs = [];

  notify() => notifyListeners();
}

class Shift {
  final DateTime start;
  final DateTime end;
  DateTime? checkIn;
  DateTime? checkOut;

  Shift(this.start, this.end);
}

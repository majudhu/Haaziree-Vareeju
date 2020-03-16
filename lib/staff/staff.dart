import 'package:flutter/foundation.dart';

class Staff {
  int staffId;
  String name;
  final shifts = List<Shift>();
  final offDays = List<DateTime>();

  Staff({this.staffId, this.name});
}

class StaffsProvider with ChangeNotifier {
  final staffs = List<Staff>();

  notify() => notifyListeners();
}

class Shift {
  final DateTime start;
  final DateTime end;
  DateTime checkIn;
  DateTime checkOut;

  Shift(this.start, this.end);
}


import 'package:flutter/foundation.dart';

class Staff {
  int staffId;
  String name;
  final shifts = List<Shift>();
  final offDays = List<DateTime>();

  Staff({this.staffId, this.name});
}

class StaffsProvider with ChangeNotifier {
  List<Staff> staffs = List<Staff>();
}

class Shift {
  final DateTime start;
  final DateTime end;

  Shift(this.start, this.end);
}

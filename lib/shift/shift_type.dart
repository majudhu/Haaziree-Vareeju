import 'package:flutter/foundation.dart';

class ShiftType {
  int shiftId;
  String name;
  Duration start;
  Duration duration;
  bool active;

  ShiftType({
    required this.shiftId,
    required this.name,
    required this.start,
    required this.duration,
    this.active = true,
  });
}

class ShiftTypeProvider with ChangeNotifier {
  List<ShiftType> shifts = [];
}

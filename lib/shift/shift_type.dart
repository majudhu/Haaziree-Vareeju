import 'package:flutter/foundation.dart';

class ShiftType {
  int shiftId;
  String name;
  Duration start;
  Duration duration;
  bool active;

  ShiftType({
    this.shiftId,
    this.name,
    this.start,
    this.duration,
    this.active = true,
  });
}

class ShiftTypeProvider with ChangeNotifier {
  List<ShiftType> shifts = List<ShiftType>();
}

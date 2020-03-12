import 'package:flutter/material.dart';
import 'package:haazireevareeju/offday/offday_type.dart';
import 'package:haazireevareeju/shift/shift_type.dart';

class ShiftTypeProvider with ChangeNotifier {
  List<ShiftType> shifts = List<ShiftType>();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

class OffDayTypeProvider with ChangeNotifier {
  List<OffDayType> offDayTypes = List<OffDayType>();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
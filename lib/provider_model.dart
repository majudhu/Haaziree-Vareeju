import 'package:flutter/material.dart';
import 'package:haazireevareeju/shift/shift_type.dart';

class ShiftTypeProvider with ChangeNotifier {
  List<ShiftType> shifts = List<ShiftType>();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

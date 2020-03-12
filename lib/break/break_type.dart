import 'package:flutter/foundation.dart';

class BreakType {
  int typeId;
  String name;
  bool paid;
  bool active;

  BreakType({
    this.typeId,
    this.name,
    this.paid,
    this.active = true,
  });
}

class BreakTypesProvider with ChangeNotifier {
  List<BreakType> offDayTypes = List<BreakType>();
}
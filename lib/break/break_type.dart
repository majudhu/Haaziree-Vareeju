import 'package:flutter/foundation.dart';

class BreakType {
  int typeId;
  String name;
  bool paid;
  bool active;

  BreakType({
    required this.typeId,
    required this.name,
    required this.paid,
    this.active = true,
  });
}

class BreakTypesProvider with ChangeNotifier {
  List<BreakType> breakTypes = [];
}

import 'package:flutter/foundation.dart';

class OffDayType {
  int typeId;
  String name;
  bool paid;
  bool active;

  OffDayType({
    required this.typeId,
    required this.name,
    required this.paid,
    this.active = true,
  });
}

class OffDayTypeProvider with ChangeNotifier {
  List<OffDayType> offDayTypes = [];
}

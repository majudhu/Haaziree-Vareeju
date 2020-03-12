import 'package:flutter/foundation.dart';

class OffDayType {
  int typeId;
  String name;
  bool paid;
  bool active;

  OffDayType({
    this.typeId,
    this.name,
    this.paid,
    this.active = true,
  });
}

class OffDayTypeProvider with ChangeNotifier {
  List<OffDayType> offDayTypes = List<OffDayType>();
}
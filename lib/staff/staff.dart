import 'package:flutter/foundation.dart';

class Staff {
  int staffId;
  String name;

  Staff({
    this.staffId,
    this.name
  });
}

class StaffsProvider with ChangeNotifier {
  List<Staff> staffs = List<Staff>();
}

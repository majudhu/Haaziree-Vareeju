import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'break/break_type.dart';
import 'holidays/holiday.dart';
import 'home.dart';
import 'settings/settings.dart';
import 'staff/staff.dart';
import 'shift/shift_type.dart';
import 'offday/offday_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShiftTypeProvider>(
          create: (context) => ShiftTypeProvider(),
        ),
        ChangeNotifierProvider<OffDayTypeProvider>(
          create: (context) => OffDayTypeProvider(),
        ),
        ChangeNotifierProvider<BreakTypesProvider>(
          create: (context) => BreakTypesProvider(),
        ),
        ChangeNotifierProvider<HolidaysProvider>(
          create: (context) => HolidaysProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider<StaffsProvider>(
          create: (context) => StaffsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Attendance Prototype',
        home: HomePage(),
      ),
    );
  }
}

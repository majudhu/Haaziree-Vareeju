import 'package:flutter/material.dart';
import 'package:haazireevareeju/break/break_type.dart';
import 'package:haazireevareeju/holidays/holiday.dart';
import 'package:haazireevareeju/home.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        title: 'Attendance Prototype',
        home: HomePage(),
      ),
    );
  }
}

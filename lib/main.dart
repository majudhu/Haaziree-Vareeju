import 'package:flutter/material.dart';
import 'package:haazireevareeju/home.dart';
import 'package:haazireevareeju/provider_model.dart';
import 'package:provider/provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Attendance Prototype',
        home: HomePage(),
      ),
    );
  }
}

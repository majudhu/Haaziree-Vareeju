import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'staff/staffs_page.dart';
import 'holidays/holidays_page.dart';
import 'settings/settings_page.dart';
import 'offday/offdays_page.dart';
import 'shift/shifts_page.dart';
import 'break/break_types_page.dart';

class HomePage extends StatelessWidget {
  static const platform = const MethodChannel('haaziree/test');

  @override
  Widget build(BuildContext context) {
    final _method = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Protoype'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShiftsPage(),
              ),
            ),
            child: Text('Shift Types'),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OffDaysPage(),
              ),
            ),
            child: Text('Offday Types'),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BreakTypesPage(),
              ),
            ),
            child: Text('Break Types'),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HolidaysPage(),
              ),
            ),
            child: Text('Holidays'),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
            child: Text('Settings'),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StaffsPage(),
              ),
            ),
            child: Text('Staff'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _method,
              ),
              MaterialButton(
                onPressed: () async {
                  print(await platform.invokeMethod(_method.text));
                },
                child: Text('methodcall'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

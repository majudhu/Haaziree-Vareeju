import 'package:flutter/material.dart';
import 'package:haazireevareeju/shift/shifts_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Protoype'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShiftsPage(),
              ),
            ),
            child: Text('Shift Types'),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Offday Types'),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Break Types'),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Holidays'),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Settings'),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('Staff'),
          ),
        ],
      ),
    );
  }
}

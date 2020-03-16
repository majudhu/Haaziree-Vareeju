import 'package:flutter/material.dart';
import 'package:haazireevareeju/staff/create_roster_page.dart';
import 'package:haazireevareeju/staff/staff.dart';
import 'package:provider/provider.dart';

class RosterListPage extends StatelessWidget {
  final List<Shift> shifts;

  RosterListPage(this.shifts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Duty Roster")),
      body: ListView.builder(
        itemCount: shifts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(shifts[index].start.toString().substring(0, 16) +
              '(' +
              (shifts[index].checkIn?.toString()?.substring(11, 16) ?? '') +
              ')'),
          subtitle: Text(shifts[index].end.toString().substring(0, 16) +
              '(' +
              (shifts[index].checkOut?.toString()?.substring(11, 16) ?? '') +
              ')'),
          trailing: IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              shifts.removeAt(index);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateRosterPage(shifts),
          ),
        ),
      ),
    );
  }
}

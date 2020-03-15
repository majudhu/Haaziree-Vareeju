import 'package:flutter/material.dart';
import 'package:haazireevareeju/staff/create_roster_page.dart';
import 'package:haazireevareeju/staff/staff.dart';
import 'package:haazireevareeju/staff/staff_edit_page.dart';
import 'package:provider/provider.dart';

class RosterListPage extends StatelessWidget {
  final Staff staff;

  RosterListPage(this.staff);

  @override
  Widget build(BuildContext context) {
    return Provider<List<Shift>>(
      create: (_) => List<Shift>.from(staff.shifts),
      child: Scaffold(
        appBar: AppBar(title: Text("Duty Roster")),
        body: Consumer<List<Shift>>(
          builder: (context, shifts, _) => ListView.builder(
            itemCount: shifts.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(shifts[index].start.toString()),
              subtitle: Text(shifts[index].start.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  shifts.removeAt(index);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateRosterPage(staff.shifts),
            ),
          ),
        ),
      ),
    );
  }
}

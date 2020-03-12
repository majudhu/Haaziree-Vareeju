import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shift_edit_page.dart';
import 'shift_type.dart';

class ShiftsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shifts List'),
      ),
      body: Consumer<ShiftTypeProvider>(
        builder: (context, shiftTypes, child) {
          return ListView.builder(
            itemCount: shiftTypes.shifts.length,
            itemBuilder: (context, index) {
              final shift = shiftTypes.shifts[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShiftEditPage(shift),
                  ),
                ),
                title: Text(
                  shift.name,
                  style: TextStyle(
                      decoration:
                          shift.active ? null : TextDecoration.lineThrough),
                ),
                subtitle: Text(shift.start.toString().substring(0, 7)),
                trailing: Text(shift.duration.toString().substring(0, 5)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShiftEditPage(),
          ),
        ),
      ),
    );
  }
}

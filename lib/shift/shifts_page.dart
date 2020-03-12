import 'package:flutter/material.dart';
import 'package:haazireevareeju/shift/shift_edit_page.dart';
import 'package:provider/provider.dart';

import 'package:haazireevareeju/provider_model.dart';

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
                title: Text(shift.name),
                subtitle: Text(shift.start.toString()),
                trailing: Text(shift.duration.toString()),
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

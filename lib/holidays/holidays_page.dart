import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'holiday.dart';
import 'holidays_edit_page.dart';

class HolidaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays List'),
      ),
      body: Consumer<HolidaysProvider>(
        builder: (context, holidays, child) {
          return ListView.builder(
            itemCount: holidays.holidays.length,
            itemBuilder: (context, index) {
              final holiday = holidays.holidays[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HolidaysEditPage(holiday),
                  ),
                ),
                title: Text(holiday.name),
                subtitle: Text(holiday.date.toString().substring(0, 10)),
                trailing: Text(holiday.active ? 'active' : 'inactive'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HolidaysEditPage(),
          ),
        ),
      ),
    );
  }
}

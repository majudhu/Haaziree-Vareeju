import 'package:flutter/material.dart';
import 'package:haazireevareeju/offday/offday_edit_page.dart';
import 'package:provider/provider.dart';

import 'offday_type.dart';

class OffDaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offday Types List'),
      ),
      body: Consumer<OffDayTypeProvider>(
        builder: (context, offDayTypes, child) {
          return ListView.builder(
            itemCount: offDayTypes.offDayTypes.length,
            itemBuilder: (context, index) {
              final offDayType = offDayTypes.offDayTypes[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OffDaysEditPage(offDayType),
                  ),
                ),
                title: Text(offDayType.name),
                subtitle: Text(offDayType.paid ? 'Paid' : 'Unpaid'),
                trailing: Text(offDayType.active ? 'Active' : 'Inactive'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OffDaysEditPage(),
          ),
        ),
      ),
    );
  }
}

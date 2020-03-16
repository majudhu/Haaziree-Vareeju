import 'package:flutter/material.dart';
import 'package:haazireevareeju/staff/roster_list.dart';
import 'package:provider/provider.dart';

import 'staff.dart';
import 'staff_edit_page.dart';

class StaffsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staffs List'),
      ),
      body: Consumer<StaffsProvider>(
        builder: (context, staffs, child) {
          return ListView.builder(
            itemCount: staffs.staffs.length,
            itemBuilder: (context, index) {
              final staff = staffs.staffs[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StaffEditPage(staff),
                  ),
                ),
                title: Text(staff.name),
                subtitle: Text(staff.staffId.toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StaffEditPage(),
          ),
        ),
      ),
    );
  }
}

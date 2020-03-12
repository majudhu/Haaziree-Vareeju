import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'break_type.dart';
import 'breaktype_edit_page.dart';

class BreakTypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offday Types List'),
      ),
      body: Consumer<BreakTypesProvider>(
        builder: (context, breakTypes, child) {
          return ListView.builder(
            itemCount: breakTypes.breakTypes.length,
            itemBuilder: (context, index) {
              final breakType = breakTypes.breakTypes[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BreakTypeEditPage(breakType),
                  ),
                ),
                title: Text(breakType.name),
                subtitle: Text(breakType.paid ? 'Paid' : 'Unpaid'),
                trailing: Text(breakType.active ? 'Active' : 'Inactive'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BreakTypeEditPage(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'staff.dart';

class StaffEditPage extends StatefulWidget {
  final Staff staff;

  StaffEditPage([this.staff]);

  @override
  _StaffEditPageState createState() => _StaffEditPageState();
}

class _StaffEditPageState extends State<StaffEditPage> {
  final _name = TextEditingController();
  final _staffId = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.staff != null)
      setState(() {
        _name.text = widget.staff.name;
        _staffId.text = widget.staff.staffId.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Edit'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextField(
            controller: _staffId,
            decoration: InputDecoration(labelText: 'Staff ID'),
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          MaterialButton(
            onPressed: () {
              if (widget.staff != null) {
                widget.staff.staffId = int.tryParse(_staffId.text);
                widget.staff.name = _name.text;
              } else {
                Provider.of<StaffsProvider>(context, listen: false)
                  ..staffs.add(
                    Staff(
                      staffId: int.tryParse(_staffId.text),
                      name: _name.text,
                    ),
                  )
                  ..notify();
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

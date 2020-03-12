import 'package:flutter/material.dart';
import 'package:haazireevareeju/shift/shift_type.dart';
import 'package:provider/provider.dart';

import 'package:haazireevareeju/provider_model.dart';

class ShiftEditPage extends StatefulWidget {
  final ShiftType shift;

  ShiftEditPage([this.shift]);

  @override
  _ShiftEditPageState createState() => _ShiftEditPageState();
}

class _ShiftEditPageState extends State<ShiftEditPage> {
  @override
  Widget build(BuildContext context) {
    final shiftId = TextEditingController();
    final name = TextEditingController();
    final start = TextEditingController();
    final duration = TextEditingController();
    final active = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Shift Type'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: shiftId,
            decoration: InputDecoration(labelText: 'Shift ID'),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: start,
            decoration: InputDecoration(labelText: 'Start'),
          ),
          TextField(
            controller: duration,
            decoration: InputDecoration(labelText: 'Duration'),
          ),
          TextField(
            controller: active,
            decoration: InputDecoration(labelText: 'Active'),
          ),
          MaterialButton(
            onPressed: () {
              if (widget.shift != null) {
                widget.shift.shiftId = 1;
                widget.shift.start = DateTime.now();
                widget.shift.name = 'Morning';
                widget.shift.duration = Duration(hours: 1);
                widget.shift.active = true;
              } else {
                Provider.of<ShiftTypeProvider>(context, listen: false)
                    .shifts
                    .add(
                      ShiftType(
                        shiftId: 1,
                        start: DateTime.now(),
                        name: 'Morning',
                        active: true,
                        duration: Duration(hours: 1),
                      ),
                    );
              }
              Provider.of<ShiftTypeProvider>(context, listen: false)
                  .notifyListeners();
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}

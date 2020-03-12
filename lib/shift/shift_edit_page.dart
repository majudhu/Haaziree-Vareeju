import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shift_type.dart';

class ShiftEditPage extends StatefulWidget {
  final ShiftType shift;

  ShiftEditPage([this.shift]);

  @override
  _ShiftEditPageState createState() => _ShiftEditPageState();
}

class _ShiftEditPageState extends State<ShiftEditPage> {
  final _shiftId = TextEditingController();
  final _name = TextEditingController();
  TimeOfDay _start;
  TimeOfDay _end;
  bool _active = true;

  @override
  void initState() {
    super.initState();
    if (widget.shift != null)
      setState(() {
        _shiftId.text = widget.shift.shiftId.toString();
        _name.text = widget.shift.name;
        _start = TimeOfDay(
          hour: widget.shift.start.inHours,
          minute: widget.shift.start.inMinutes % 60,
        );
        final end = widget.shift.start + widget.shift.duration;
        _end = TimeOfDay(
          hour: end.inHours % 24,
          minute: end.inMinutes % 60,
        );
        _active = widget.shift.active;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Shift Type'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextField(
            controller: _shiftId,
            decoration: InputDecoration(labelText: 'Shift ID'),
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(labelText: 'Start'),
            controller: TextEditingController(text: _start?.format(context)),
            onTap: () async {
              final start = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 0, minute: 0),
              );
              setState(() => _start = start);
            },
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(labelText: 'End'),
            controller: TextEditingController(text: _end?.format(context)),
            onTap: () async {
              final end = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 0, minute: 0),
              );

              setState(() => _end = end);
            },
          ),
          CheckboxListTile(
            title: Text("Active"),
            value: _active,
            onChanged: (value) => setState(() => _active = value),
          ),
//          TextField(
//            controller: active,
//            decoration: InputDecoration(labelText: 'Active'),
//          ),
          MaterialButton(
            onPressed: () {
              final end = Duration(hours: _end.hour, minutes: _end.minute);
              final start =
                  Duration(hours: _start.hour, minutes: _start.minute);
              var duration = end - start;
              if (duration.isNegative) duration += Duration(days: 1);

              if (widget.shift != null) {
                widget.shift.shiftId = int.tryParse(_shiftId.text);
                widget.shift.name = _name.text;
                widget.shift.start = start;
                widget.shift.duration = duration;
                widget.shift.active = _active;
              } else {
                Provider.of<ShiftTypeProvider>(context, listen: false)
                    .shifts
                    .add(
                      ShiftType(
                        shiftId: int.tryParse(_shiftId.text),
                        name: _name.text,
                        start: start,
                        duration: duration,
                        active: _active,
                      ),
                    );
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}

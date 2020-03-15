import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haazireevareeju/staff/staff.dart';

class CreateRosterPage extends StatefulWidget {
  final List<Shift> shifts;

  CreateRosterPage(this.shifts);

  @override
  _CreateRosterPageState createState() => _CreateRosterPageState();
}

class _CreateRosterPageState extends State<CreateRosterPage> {
  bool _sundayOff = true;
  bool _mondayOff = true;
  bool _tuesdayOff = true;
  bool _wednesdayOff = true;
  bool _thursdayOff = true;
  bool _fridayOff = false;
  bool _saturdayOff = true;
  DateTime _rosterStart = DateTime.now().add(Duration(days: 1));
  DateTime _rosterEnd = DateTime.now().add(Duration(days: 31));
  TimeOfDay _shiftStart = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _shiftEnd = TimeOfDay(hour: 1, minute: 0);

  @override
  Widget build(BuildContext context) {
    final nextDay = ((_shiftEnd.hour * 60 + _shiftEnd.minute) <
        (_shiftStart.hour * 60 + _shiftStart.minute));
    return Scaffold(
      appBar: AppBar(title: Text('Create Roster')),
      body: ListView(
        children: <Widget>[
          Text('Create Roster', style: Theme.of(context).textTheme.headline),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _rosterStart.toString().substring(0, 10),
                  ),
                  decoration: InputDecoration(labelText: 'From'),
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: _rosterStart,
                    firstDate: DateTime.now().subtract(
                      Duration(days: 1),
                    ),
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then(
                    (date) =>
                        setState(() => _rosterStart = date ?? _rosterStart),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _rosterEnd.toString().substring(0, 10),
                  ),
                  decoration: InputDecoration(labelText: 'To'),
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: _rosterEnd,
                    firstDate: _rosterStart,
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then(
                    (date) => setState(() => _rosterEnd = date ?? _rosterEnd),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: TextEditingController(
                    text: (_rosterEnd.difference(_rosterStart).inDays + 1)
                        .toString(),
                  ),
                  decoration: InputDecoration(labelText: '# Days'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  onSubmitted: (days) => setState(
                    () => _rosterEnd = _rosterStart.add(
                      Duration(days: (int.tryParse(days) ?? 1) - 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _shiftStart.format(context),
                  ),
                  decoration: InputDecoration(labelText: 'Shift Start'),
                  onTap: () => showTimePicker(
                    context: context,
                    initialTime: _shiftStart,
                  ).then(
                    (time) => setState(() => _shiftStart = time ?? _shiftStart),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _shiftEnd.format(context),
                  ),
                  decoration: InputDecoration(labelText: 'Shift End'),
                  onTap: () => showTimePicker(
                    context: context,
                    initialTime: _shiftEnd,
                  ).then(
                    (time) => setState(() => _shiftEnd = time ?? _shiftEnd),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: TextEditingController(
                    text:
                        (_shiftEnd.hour - _shiftStart.hour + (nextDay ? 24 : 0))
                            .toString(),
                  ),
                  decoration: InputDecoration(labelText: 'hrs'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Working Days',
                style: Theme.of(context).textTheme.subhead),
          ),
          Row(
            children: <Widget>[
              Ink(
                decoration: ShapeDecoration(
                  color: _sundayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _sundayOff = !_sundayOff),
                  icon: Text('S'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _mondayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _mondayOff = !_mondayOff),
                  icon: Text('M'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _tuesdayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _tuesdayOff = !_tuesdayOff),
                  icon: Text('T'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _wednesdayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () =>
                      setState(() => _wednesdayOff = !_wednesdayOff),
                  icon: Text('W'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _thursdayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _thursdayOff = !_thursdayOff),
                  icon: Text('T'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _fridayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _fridayOff = !_fridayOff),
                  icon: Text('F'),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: _saturdayOff
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _saturdayOff = !_saturdayOff),
                  icon: Text('S'),
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              final dates = List.generate(
                _rosterEnd.difference(_rosterStart).inDays + 1,
                (index) => _rosterStart.add(
                  Duration(days: index),
                ),
              );
              dates.removeWhere(
                (date) => ![
                  _mondayOff,
                  _tuesdayOff,
                  _wednesdayOff,
                  _thursdayOff,
                  _fridayOff,
                  _saturdayOff,
                  _sundayOff,
                ][date.weekday - 1],
              );
              final shifts = dates.map(
                (date) => Shift(
                  DateTime(
                    date.year,
                    date.month,
                    date.day,
                    _shiftStart.hour,
                    _shiftStart.minute,
                  ),
                  DateTime(
                    date.year,
                    date.month,
                    date.day + (nextDay ? 1 : 0),
                    _shiftEnd.hour,
                    _shiftEnd.minute,
                  ),
                ),
              );
              widget.shifts.addAll(shifts);
              // widget.staff.shifts.addAll(dates);
            },
            child: Text('Create Roster'),
          ),
        ],
      ),
    );
  }
}

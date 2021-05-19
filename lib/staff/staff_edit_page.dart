import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haazireevareeju/holidays/holiday.dart';
import 'package:haazireevareeju/staff/roster_list.dart';
import 'package:provider/provider.dart';

import 'create_roster_page.dart';
import 'staff.dart';

class StaffEditPage extends StatefulWidget {
  final Staff? staff;

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
        _name.text = widget.staff!.name;
        _staffId.text = widget.staff!.staffId.toString();
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
                widget.staff!.staffId = int.tryParse(_staffId.text) ?? 0;
                widget.staff!.name = _name.text;
              } else {
                Provider.of<StaffsProvider>(context, listen: false)
                  ..staffs.add(
                    Staff(
                      staffId: int.tryParse(_staffId.text) ?? 0,
                      name: _name.text,
                    ),
                  )
                  ..notify();
              }
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          if (widget.staff != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CreateRosterPage(widget.staff!.shifts))),
                  child: Text('Create Roster'),
                ),
                MaterialButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RosterListPage(widget.staff!.shifts))),
                  child: Text('View Roster'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    final now = DateTime.now();

                    final holidays =
                        Provider.of<HolidaysProvider>(context, listen: false)
                            .holidays;
                    try {
                      final holidayToday = holidays.firstWhere(
                        (holiday) => (holiday.date.year == now.year &&
                            holiday.date.month == now.month &&
                            holiday.date.day == now.day),
                      );
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Today is a holiday'),
                          content: Text('Today is ${holidayToday.name}'),
                        ),
                      );
                      return;
                    } catch (_) {}

                    Shift currentShift = widget.staff!.shifts.first;
                    for (final shift in widget.staff!.shifts) {
                      if (shift.end.isAfter(now)) {
                        if (shift.start.isBefore(now)) {
                          currentShift = shift;
                          break;
                        }
                        if (shift.start.difference(now) <
                            currentShift.start.difference(now)) {
                          currentShift = shift;
                        }
                      }
                    }
                    if (currentShift.end.isAfter(now)) {
                      if (currentShift.start.isBefore(now)) {
                        currentShift.checkIn = now;
                        final late =
                            now.difference(currentShift.start).inMinutes;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('You are $late minutes late'),
                            content: Text('Checked-in to ' +
                                currentShift.start
                                    .toString()
                                    .substring(11, 16)),
                          ),
                        );
                        return;
                      } else {
                        if (currentShift.start.difference(now).inMinutes < 30) {
                          currentShift.checkIn = now;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Checked in to shift'),
                              content: Text(
                                currentShift.start.toString().substring(11, 16),
                              ),
                            ),
                          );
                          return;
                        }
                      }
                    }
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('No shift found'),
                      ),
                    );
                  },
                  child: Text('Check-In'),
                ),
                MaterialButton(
                  onPressed: () {
                    final now = DateTime.now();
                    try {
                      final currentShift = widget.staff!.shifts.firstWhere(
                        (shift) =>
                            (shift.checkIn != null) &&
                            (shift.checkOut == null) &&
                            (shift.end.isBefore(now)) &&
                            (now.difference(shift.end).inMinutes < 30),
                      );
                      currentShift.checkOut = now;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Checked out from shift'),
                          content: Text(
                              currentShift.start.toString().substring(11, 16)),
                        ),
                      );
                    } on StateError {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Not shift found'),
                        ),
                      );
                    }
                  },
                  child: Text('Check-Out'),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}

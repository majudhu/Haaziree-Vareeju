import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'holiday.dart';

class HolidaysEditPage extends StatefulWidget {
  final Holiday holiday;

  HolidaysEditPage([this.holiday]);

  @override
  _HolidaysEditPageState createState() => _HolidaysEditPageState();
}

class _HolidaysEditPageState extends State<HolidaysEditPage> {
  final _name = TextEditingController();
  DateTime _date;
  bool _active = true;

  @override
  void initState() {
    super.initState();
    if (widget.holiday != null)
      setState(() {
        _name.text = widget.holiday.name;
        _date = widget.holiday.date;
        _active = widget.holiday.active;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday Edit'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            readOnly: true,
            controller: TextEditingController(
                text: _date?.toString()?.substring(0, 10)),
            decoration: InputDecoration(
              labelText: 'Date'
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
              );
              setState(() => _date = date);
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
              if (widget.holiday != null) {
                widget.holiday.name = _name.text;
                widget.holiday.active = _active;
                widget.holiday.date = _date;
              } else {
                Provider.of<HolidaysProvider>(context, listen: false)
                    .holidays
                    .add(
                      Holiday(
                        name: _name.text,
                        date: _date,
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

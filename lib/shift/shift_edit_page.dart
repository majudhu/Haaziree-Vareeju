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

  final shiftId = TextEditingController();
  final name = TextEditingController();
  final start = TextEditingController();
  final duration = TextEditingController();
  final active = TextEditingController();
  final hours = TextEditingController();
  final miniutes = TextEditingController();
  bool _active = true;


  @override
  void initState(){
    super.initState();
    if(widget.shift != null)
      setState(() {
        shiftId.text = widget.shift.shiftId.toString();
        name.text = widget.shift.name;
        start.text = widget.shift.start.toString();
        duration.text = widget.shift.duration.toString();
        active.text = widget.shift.active.toString();
      });
  }


  @override
  Widget build(BuildContext context) {


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
          Row(
            children: <Widget>[
              Text("Duration"),

              Expanded(
                child: TextField(
                  controller: hours,
                  decoration: InputDecoration(labelText: 'Hours'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: miniutes,
                  decoration: InputDecoration(labelText: 'Minutes'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          CheckboxListTile(
            title: Text("Active"),
            value: _active,
            onChanged: (bool resp){
              setState(() {
                _active = !resp;
              });
            },
          ),
//          TextField(
//            controller: active,
//            decoration: InputDecoration(labelText: 'Active'),
//          ),
          MaterialButton(
            onPressed: () {
              if (widget.shift != null) {
                widget.shift.shiftId = int.tryParse(shiftId.text);
                widget.shift.start = DateTime.tryParse(start.text);
                widget.shift.name = name.text;
                widget.shift.duration = Duration(hours: int.tryParse(duration.text));
                widget.shift.active = _active;
              } else {
                Provider.of<ShiftTypeProvider>(context, listen: false)
                    .shifts
                    .add(
                       ShiftType(
                        shiftId: int.tryParse(shiftId.text),
                        start: DateTime.tryParse(start.text),
                        name: name.text,
                        active: _active,
                        duration: Duration(hours: int.tryParse(duration.text)),
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

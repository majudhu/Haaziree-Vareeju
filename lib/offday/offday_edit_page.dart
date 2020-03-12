import 'package:flutter/material.dart';
import 'package:haazireevareeju/offday/offday_type.dart';
import 'package:haazireevareeju/shift/shift_type.dart';
import 'package:provider/provider.dart';

import 'package:haazireevareeju/provider_model.dart';

class OffDaysEditPage extends StatefulWidget {
  final OffDayType offDayType;

  OffDaysEditPage([this.offDayType]);

  @override
  _OffDaysEditPageState createState() => _OffDaysEditPageState();
}

class _OffDaysEditPageState extends State<OffDaysEditPage> {
  final offDayTypeId = TextEditingController();
  final name = TextEditingController();
  bool paid = true;
  bool active = true;

  @override
  void initState() {
    super.initState();
    if (widget.offDayType != null)
      setState(() {
        offDayTypeId.text = widget.offDayType.typeId.toString();
        name.text = widget.offDayType.name;
        paid = widget.offDayType.paid;
        active = widget.offDayType.active;
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
            controller: offDayTypeId,
            decoration: InputDecoration(labelText: 'Offday Type ID'),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          Switch(
            value: paid,
            onChanged: (value) => setState(() => paid = value),
          ),
          Switch(
            value: active,
            onChanged: (value) => setState(() => active = value),
          ),
          MaterialButton(
            onPressed: () {
              if (widget.offDayType != null) {
                widget.offDayType.typeId = int.tryParse(offDayTypeId.text);
                widget.offDayType.name = name.text;
                widget.offDayType.paid = paid;
                widget.offDayType.active = active;
              } else {
                Provider.of<OffDayTypeProvider>(context, listen: false)
                    .offDayTypes
                    .add(
                      OffDayType(
                        typeId: int.tryParse(offDayTypeId.text),
                        name: name.text,
                        active: paid,
                        paid: active,
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

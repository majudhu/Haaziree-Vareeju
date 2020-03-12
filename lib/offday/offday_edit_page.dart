import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'offday_type.dart';

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
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          TextField(
            controller: offDayTypeId,
            decoration: InputDecoration(labelText: 'Offday Type ID'),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          CheckboxListTile(
            title: Text('Paid'),
            value: paid,
            onChanged: (value) => setState(() => paid = value),
          ),
          CheckboxListTile(
            title: Text('Active'),
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
              } else
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
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}

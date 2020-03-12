import 'package:flutter/material.dart';
import 'package:haazireevareeju/break/break_type.dart';
import 'package:haazireevareeju/offday/offday_type.dart';
import 'package:provider/provider.dart';

class BreakTypeEditPage extends StatefulWidget {
  final BreakType breakType;

  BreakTypeEditPage([this.breakType]);

  @override
  _BreakTypeEditPageState createState() => _BreakTypeEditPageState();
}

class _BreakTypeEditPageState extends State<BreakTypeEditPage> {
  final offDayTypeId = TextEditingController();
  final name = TextEditingController();
  bool paid = true;
  bool active = true;

  @override
  void initState() {
    super.initState();
    if (widget.breakType != null)
      setState(() {
        offDayTypeId.text = widget.breakType.typeId.toString();
        name.text = widget.breakType.name;
        paid = widget.breakType.paid;
        active = widget.breakType.active;
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
              if (widget.breakType != null) {
                widget.breakType.typeId = int.tryParse(offDayTypeId.text);
                widget.breakType.name = name.text;
                widget.breakType.paid = paid;
                widget.breakType.active = active;
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

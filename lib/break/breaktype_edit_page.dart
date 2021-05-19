import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'break_type.dart';

class BreakTypeEditPage extends StatefulWidget {
  final BreakType? breakType;

  BreakTypeEditPage([this.breakType]);

  @override
  _BreakTypeEditPageState createState() => _BreakTypeEditPageState();
}

class _BreakTypeEditPageState extends State<BreakTypeEditPage> {
  final breakTypeId = TextEditingController();
  final name = TextEditingController();
  bool paid = true;
  bool active = true;

  @override
  void initState() {
    super.initState();
    try {
      final breakType = widget.breakType!;
      setState(() {
        breakTypeId.text = breakType.typeId.toString();
        name.text = breakType.name;
        paid = breakType.paid;
        active = breakType.active;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Break Type'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          TextField(
            controller: breakTypeId,
            decoration: InputDecoration(labelText: 'Break Type ID'),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          CheckboxListTile(
            title: Text('Paid'),
            value: paid,
            onChanged: (value) => setState(() => paid = value ?? paid),
          ),
          CheckboxListTile(
            title: Text('Active'),
            value: active,
            onChanged: (value) => setState(() => active = value ?? active),
          ),
          MaterialButton(
            onPressed: () {
              if (widget.breakType != null) {
                widget.breakType!.typeId = int.tryParse(breakTypeId.text) ?? 0;
                widget.breakType!.name = name.text;
                widget.breakType!.paid = paid;
                widget.breakType!.active = active;
              } else
                Provider.of<BreakTypesProvider>(context, listen: false)
                    .breakTypes
                    .add(
                      BreakType(
                        typeId: int.tryParse(breakTypeId.text) ?? 0,
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

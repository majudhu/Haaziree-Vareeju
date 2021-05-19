import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TimeOfDay _checkInGrace;

  SettingsProvider? _settings;

  @override
  void initState() {
    super.initState();
    _settings = Provider.of<SettingsProvider>(context, listen: false);
    setState(() {
      _checkInGrace = TimeOfDay(
        hour: _settings?.checkInGrace.inHours ?? 0,
        minute: (_settings?.checkInGrace.inMinutes ?? 0) % 60,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          TextField(
            readOnly: true,
            decoration: InputDecoration(labelText: 'Check-In Grace Time'),
            controller: TextEditingController(
                text: _checkInGrace.format(context).substring(0, 5)),
            onTap: () async {
              final checkInGrace = await showTimePicker(
                context: context,
                initialTime: _checkInGrace,
              );
              setState(() => _checkInGrace = checkInGrace ?? _checkInGrace);
            },
          ),
          MaterialButton(
            child: Text('Save'),
            onPressed: () async {
              _settings?.checkInGrace = Duration(
                hours: _checkInGrace.hour,
                minutes: _checkInGrace.minute,
              );
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

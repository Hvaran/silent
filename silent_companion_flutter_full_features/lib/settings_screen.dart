import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool musicEnabled;
  final Function(bool) onMusicToggle;
  final Function() onClearJournal;

  SettingsScreen({
    required this.musicEnabled,
    required this.onMusicToggle,
    required this.onClearJournal,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool testModuleEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Налаштування'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Музика'),
            value: widget.musicEnabled,
            onChanged: (val) {
              widget.onMusicToggle(val);
              setState(() {});
            },
          ),
          SwitchListTile(
            title: Text('Модуль тестів (beta)'),
            value: testModuleEnabled,
            onChanged: (val) {
              setState(() {
                testModuleEnabled = val;
              });
            },
          ),
          ListTile(
            title: Text('Очистити журнал'),
            trailing: Icon(Icons.delete),
            onTap: () {
              widget.onClearJournal();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Журнал очищено. Ти завжди можеш почати знову, брате.'),
              ));
            },
          )
        ],
      ),
    );
  }
}

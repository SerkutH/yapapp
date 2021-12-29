import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yapapp/models/color_theme_data.dart';

class SettingsPage extends StatelessWidget {
  late bool _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose Theme'),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SwitchCard());
  }
}

class SwitchCard extends StatefulWidget {
  const SwitchCard({Key? key}) : super(key: key);

  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    Text greenText = Text(
      'Green',
      style: TextStyle(color: Theme.of(context).primaryColor),
    );
    Text redText = Text(
      'Red',
      style: TextStyle(color: Colors.red),
    );
    bool _value = Provider.of<ColorThemeData>(context).isGreen;
    return Card(
      child: SwitchListTile(
        subtitle: _value ? greenText : redText,
        title: Text('Change background color',
            style: TextStyle(color: Colors.black54)),
        value: _value,
        onChanged: (bool value) {
          Provider.of<ColorThemeData>(context, listen: false)
              .switchTheme(value);
        },
      ),
    );
  }
}

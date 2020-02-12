import 'package:daisy/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          RaisedButton(
            child: Text('Light Theme'),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).setTheme('light');
            },
          ),
          RaisedButton(
            child: Text('Dark Theme'),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).setTheme('dark');
            },
          )
        ]),
      ),
    );
  }
}

import 'package:daisy/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class LibraryPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choice>(
      onSelected: (choise) {
        if (choise.title == 'Settings') {
          Navigator.pushNamed(context, SettingsScreen.routeName);
        }
      },
      itemBuilder: (BuildContext context) {
        return choices.map((Choice choice) {
          return PopupMenuItem<Choice>(
            value: choice,
            child: Text(choice.title),
          );
        }).toList();
      },
    );
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Settings', icon: Icons.settings),
];

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

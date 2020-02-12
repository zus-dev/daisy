import 'package:daisy/screens/library/library_screen.dart';
import 'package:daisy/screens/settings/settings_screen.dart';
import 'package:daisy/screens/story/story_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => LibraryScreen(),
  StoryScreen.routeName: (context) => StoryScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
};

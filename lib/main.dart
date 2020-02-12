import 'package:daisy/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';
import 'routes.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(create: (_) => ThemeModel()),
        ChangeNotifierProvider<StoryModel>(create: (_) => StoryModel()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daisy',
      theme: Provider.of<ThemeModel>(context).theme,
      routes: routes,
      initialRoute: '/',
    );
  }
}

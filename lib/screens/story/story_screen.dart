import 'package:flutter/material.dart';

import 'story_input.dart';
import 'story_view.dart';

class StoryScreen extends StatelessWidget {
  static const routeName = '/story';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StoryView(),
              StoryInput(),
            ],
          ),
        ),
      ),
    );
  }
}

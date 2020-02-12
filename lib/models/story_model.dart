import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryModel extends ChangeNotifier {
  String _path;
  String _input;

  String get path => _path;

  set path(String value) {
    _path = value;
    notifyListeners();
  }

  String get input => _input;

  set input(String value) {
    _input = value;
    notifyListeners();
  }

  static StoryModel of(BuildContext context, {listen: false}) {
    return Provider.of<StoryModel>(context, listen: listen);
  }
}

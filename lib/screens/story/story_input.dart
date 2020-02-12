import 'package:daisy/models/story_model.dart';
import 'package:daisy/theme/style.dart';
import 'package:flutter/material.dart';

typedef void InputCallback(String message);

class StoryInput extends StatefulWidget {
  @override
  _StoryInputState createState() => _StoryInputState();
}

class _StoryInputState extends State<StoryInput> {
  TextEditingController _messageController = TextEditingController();
  String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (value) {
                //Do something with the user input.
                _message = value;
              },
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          FlatButton(
            onPressed: () async {
              //Implement send functionality.
              StoryModel.of(context).input = _message;
              _messageController.clear();
            },
            child: Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

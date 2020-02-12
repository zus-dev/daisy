import 'dart:io';

import 'package:daisy/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:zvm/zvm.dart';

class StoryView extends StatefulWidget {
  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  final messages = List<String>();
  final screenModelListener = TestScreenModelListener();
  final initStruct = MachineInitStruct();
  ExecutionControl executionControl;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initStory();

    StoryModel.of(context).addListener(() {
      final input = StoryModel.of(context).input;
      print('INPUT: $input');
      resumeWithInput(input);
    });
  }

  void initStory() async {
    BufferedScreenModel screenModel = BufferedScreenModel();
    screenModel.addScreenModelListener(screenModelListener);

    initStruct.storyFile = FileBytesInputStream(StoryModel.of(context).path);
    initStruct.nativeImageFactory = TestImageFactory();
    initStruct.saveGameDataStore = TestSaveGameDataStore();
    initStruct.ioSystem = TestIOSystem();
    initStruct.screenModel = screenModel;
    initStruct.statusLine = screenModel;

    executionControl = ExecutionControl(initStruct);
    // initUI(initStruct);
    {
      screenModel.init(
        executionControl.getMachine(),
        executionControl.getZsciiEncoding(),
      );
    }

    MachineRunState runState = executionControl.run();
    print("PAUSING WITH STATE: " + runState.toString());

    // executionControl.resumeWithInput("n");
    // print("PAUSING WITH STATE: " + runState.toString());

    updateMessages();
  }

  void resumeWithInput(String input) {
    executionControl.resumeWithInput(input);
    // print("PAUSING WITH STATE: " + runState.toString());
    updateMessages();
  }

  void updateMessages() {
    setState(() {
      messages.clear();
      for (final segment in screenModelListener.segments.reversed) {
        messages.add(removePrompt(segment));
      }
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 400),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          controller: _scrollController,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Material(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 5.0),
                    child: Container(
                      child: Text(
                        '${messages[index]}',
                        style: index > 0
                            ? Theme.of(context).textTheme.body1
                            : Theme.of(context).textTheme.body2,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

String removePrompt(String message) {
  final promptIndex = message.lastIndexOf(RegExp('>\s*\$'));
  if (promptIndex > 0) {
    message = message.substring(0, promptIndex);
  }

  return message.trim();
}

class FileBytesInputStream extends BytesInputStream {
  String fileName;

  FileBytesInputStream(this.fileName);

  @override
  ByteArray readAsBytesSync() {
    final file = File(fileName);
    return ByteArray(file.readAsBytesSync());
  }

  @override
  void mark(int readLimit) {
    // TODO: implement mark
  }

  @override
  int read() {
    // TODO: implement read
    return null;
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}

class TestImageFactory extends NativeImageFactory {
  @override
  NativeImage createImage(BytesInputStream inputStream) {
    // TODO: implement createImage
    return null;
  }
}

class TestSaveGameDataStore extends SaveGameDataStore {
  @override
  FormChunk retrieveFormChunk() {
    // TODO: implement retrieveFormChunk
    return null;
  }

  @override
  bool saveFormChunk(WritableFormChunk formchunk) {
    // TODO: implement saveFormChunk
    return null;
  }
}

class TestIOSystem extends IOSystem {
  @override
  Reader getInputStreamReader() {
    // TODO: implement getInputStreamReader
    return null;
  }

  @override
  Writer getTranscriptWriter() {
    // TODO: implement getTranscriptWriter
    return null;
  }
}

class TestScreenModelListener extends ScreenModelListener {
  final segments = List<String>();
  @override
  void screenModelUpdated(ScreenModel screenModel) {
    StringBuffer lower = StringBuffer();
    if (screenModel is BufferedScreenModel) {
      List<AnnotatedText> text = screenModel.getLowerBuffer();
      for (AnnotatedText segment in text) {
        lower.write(segment.getText());
      }
      // flush and set styles
      /// lower.setCurrentStyle(screenModel.getBottomAnnotation());
      /// TODO: Distinguish C1OpInstruction._print_obj and make annotations for
      /// a "room" and an "object"
      /// e.g. encrusted/src/rust/ui_web.rs fn flush
      // print(lower.toString());
      segments.add(lower.toString());
      //upper.setCurrentStyle(screenModel.getBottomAnnotation());
    }
  }

  @override
  void screenSplit(int linesUpperWindow) {
    // TODO: implement screenSplit
  }

  @override
  void topWindowCursorMoving(int line, int column) {
    // TODO: implement topWindowCursorMoving
  }

  @override
  void topWindowUpdated(int cursorx, int cursory, AnnotatedCharacter c) {
    // TODO: implement topWindowUpdated
  }

  @override
  void windowErased(int window) {
    // TODO: implement windowErased
  }
}

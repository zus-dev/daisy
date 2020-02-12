import 'dart:io';
import 'dart:typed_data';

import 'package:daisy/models/story_model.dart';
import 'package:daisy/screens/library/library_popup_menu.dart';
import 'package:daisy/screens/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    testLocalPath();
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        actions: <Widget>[LibraryPopupMenu()],
      ),
      body: Container(
        child: StoryListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('ADD STORY TO THE LIBRARY');
          // File file = await FilePicker.getFile();
          // final _path = await FilePicker.getFilePath(
          //   type: FileType.CUSTOM, fileExtension: '');
        },
        tooltip: 'Add Story',
        child: Icon(Icons.add),
      ),
    );
  }
}

class StoryListView extends StatefulWidget {
  @override
  _StoryListViewState createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  final entries = List<String>();

  @override
  void initState() {
    super.initState();
    initStoryFiles();
  }

  void initStoryFiles() async {
    final storyFiles = await getStoryFiles();
    setState(() {
      entries.clear();
      entries.addAll(storyFiles);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(index.toString()),
                  ),
                );
                StoryModel.of(context).path = entries[index];
                Navigator.pushNamed(context, StoryScreen.routeName);
              },
              child: Material(
                elevation: 5.0,
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text('Story: ${entries[index]}'),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Future<List<String>> getStoryFiles() async {
  final storyFiles = <String>[];
  final path = await _localPath;
  final entities =
      Directory(path).listSync(followLinks: false, recursive: false);
  for (final entity in entities) {
    if (entity.path.endsWith('z3')) {
      storyFiles.add(entity.path);
    }
  }

  return storyFiles;
}

Future<Uint8List> downloadFile() async {
  final data = await http.readBytes(
      'https://textfiction.onyxbits.de/stories/zork-i-the-great-underground-empire/zork1.z3');
  return data;
}

void testLocalPath() async {
  var path = await _localPath;
  print('path: $path');
  Directory(path)
      .list(recursive: false, followLinks: false)
      .listen((FileSystemEntity entity) {
    print(entity.path);
  });

  final file = File('$path/zork1.z3');
  if (file.existsSync()) {
    // file.deleteSync();
  }

  if (!await file.exists()) {
    final bytes = await downloadFile();
    await file.writeAsBytes(bytes);
    print('downloaded');
  } else {
    print('file ${file.path} exist');
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

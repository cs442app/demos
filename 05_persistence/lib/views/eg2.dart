// Demonstrates how to save and load data to/from a file.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FilePersistenceDemo(),
    );
  }
}


class FilePersistenceDemo extends StatefulWidget {
  const FilePersistenceDemo({super.key});

  @override
  State<FilePersistenceDemo> createState() => _FilePersistenceDemoState();
}

class _FilePersistenceDemoState extends State<FilePersistenceDemo> {
  final TextEditingController _controller = TextEditingController();

  String? _filePath;

  @override
  void initState() {
    super.initState();
    _getFilePath();
  }

  Future<void> _getFilePath() async {
    // get the path to the app's directory -- note that this is established
    // by the OS/platform, so it's not something we can decide
    final directory = await getApplicationDocumentsDirectory();

    // let's pretend this takes a while ...
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _filePath = '${directory.path}/text_file.txt';
      print(_filePath);
    });
  }

  Future<void> _loadFromFile() async {
    final file = File(_filePath!);

    // skip if the file doesn't exist
    if (!file.existsSync()) return;

    final text = await file.readAsString(); // reads entire file as a string

    // let's pretend this takes a while ...
    await Future.delayed(const Duration(seconds: 1));

    _controller.text = text;
  }

  Future<void> _saveToFile() async {
    final file = File(_filePath!);

    await file.writeAsString(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notepad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: 'Enter text here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _filePath == null
                      ? null
                      : () async {
                          await _saveToFile();
                          if (!context.mounted) return; // async safety check
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Text saved to file!'),
                            ),
                          );
                        },
                  child: const Text('Save to File'),
                ),
                ElevatedButton(
                  onPressed: _filePath == null
                      ? null
                      : _loadFromFile,
                  child: const Text('Load from File'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Demonstrates:
// - defining a model class that loads/serializes itself from/to JSON
// - the typical workflow of copying a file from the assets bundle to the 
//   data directory and writing changes there

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../models/person.dart';

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PersonView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  late Future<Person> _person;

  @override
  initState() {
    super.initState();
    _person = _loadData(context);
  }

  Future<String> _dataFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/data.json';
  }

  Future<Person> _loadData(BuildContext context, {bool reset = false}) async {
    var data =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');

    final file = File(await _dataFilePath());

    if (reset) {
      // overwrite the file with the asset data
      await file.writeAsString(data);
    } else if (file.existsSync()) {
      // otherwise, use updated file (if it exists)
      data = await file.readAsString();
    }

    return Person.fromJson(json.decode(data));
  }

  Future<void> _writeData(Person person) async {
    final file = File(await _dataFilePath());
    await file.writeAsString(json.encode(person.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
        future: _person,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final person = snapshot.data as Person;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Person Info'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () async {
                      setState(() {
                        _person = _loadData(context, reset: true);
                      });
                    },
                  ),
                ],
              ),
              body: ListView(
                children: [
                  EditableListTile(
                      title: 'Name',
                      value: person.name,
                      onChanged: (name) async {
                        person.name = name;
                        await _writeData(person);
                        setState(() {
                          _person = Future.value(person);
                        });
                      }),
                  EditableListTile(
                      title: 'Age',
                      value: person.age.toString(),
                      onChanged: (age) async {
                        person.age = int.parse(age);
                        await _writeData(person);
                        setState(() {
                          _person = Future.value(person);
                        });
                      }),
                  EditableListTile(
                      title: 'Email',
                      value: person.email,
                      onChanged: (email) async {
                        person.email = email;
                        await _writeData(person);
                        setState(() {
                          _person = Future.value(person);
                        });
                      }),
                  ListTile(
                    title: const Text('Address'),
                    subtitle: Text(person.address.toString()),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class EditableListTile extends StatelessWidget {
  final String title;
  final String value;
  final void Function(String) onChanged;

  const EditableListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      onTap: () async {
        final newValue = await showDialog<String>(
          context: context,
          builder: (context) {
            final controller = TextEditingController(text: value);
            return AlertDialog(
              title: Text('Edit $title'),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );

        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}

// Demonstrates:
// - how to load data from a JSON asset
// - how to use a FutureBuilder to deal with asynchronously loaded data
//   (and not delay widget rendering)

import 'dart:convert';
import 'package:flutter/material.dart';

class App3 extends StatelessWidget {
  const App3({super.key});

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
  late Future<Map<String,dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = _loadData();
  }

  Future<Map<String,dynamic>> _loadData() async {
    // Load the JSON data from the asset file -- note that this is
    // read-only, as we can't write to the asset bundle.
    // (How might we handle updates to the data?)
    final data = await DefaultAssetBundle.of(context)
      .loadString('assets/data.json');

    // let's pretend this takes a while ...  
    await Future.delayed(const Duration(seconds: 2));

    // the JSON decoder returns a dynamic type -- this "shapes" it into
    // a Map of Strings to objects
    return Map<String,dynamic>.from(json.decode(data));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String,dynamic>>(
      future: _data,
      builder: (context, snapshot) {
        // `snapshot` represents the current state of our future
        // --- we can check if it's still pending, failed, or has data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Person Info'),
            ),
            body: ListView.builder(
              // `snapshot.data` is the data returned by the future
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final key = snapshot.data!.keys.elementAt(index);
                final value = snapshot.data![key];
                return ListTile(
                  title: Text(key),
                  subtitle: Text(value.toString()),
                );
              },
            ),
          );
        }
      }
    );
  }
}

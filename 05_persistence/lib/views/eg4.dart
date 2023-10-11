/// Demonstrates:
/// - how to use the provider package's FutureProvider to deal with
///   asynchronously loaded data

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// define a model class this time
class Person {
  final String name;
  final int age;
  final String email;
  final Map<String,dynamic> address;

  const Person({
    required this.name,
    required this.age,
    required this.email,
    required this.address,
  });

  // know how to load ourself from JSON
  factory Person.fromJson(Map<String,dynamic> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      address: json['address'] as Map<String,dynamic>,
    );
  }
}


class App4 extends StatelessWidget {
  const App4({super.key});

  // load the data from the asset file (asynchronously)
  Future<Person> _loadData(BuildContext context) async {
    final data = await DefaultAssetBundle.of(context)
      .loadString('assets/data.json');

    // let's pretend this takes a while ...  
    await Future.delayed(const Duration(seconds: 2));

    return Person.fromJson(json.decode(data));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // wrap the widget tree in a FutureProvider, which will provide
      // the data to any child widgets that request it (after the future
      // completes)
      home: FutureProvider<Person?>(
        create: (context) => _loadData(context),
        initialData: null,
        child: const PersonView()
      ),
    );
  }
}


class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    // get the data from the provider --- it may be null if the future
    // hasn't completed yet
    final person = Provider.of<Person?>(context);

    if (person == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: const Text('Name'),
              subtitle: Text(person.name),
            ),
            ListTile(
              title: const Text('Age'),
              subtitle: Text(person.age.toString()),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(person.email),
            ),
            ListTile(
              title: const Text('Address'),
              subtitle: Text(person.address.toString()),
            ),
          ],
        ),
      );
    }
  }
}

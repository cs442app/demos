/// Demonstrates the use of shared preferences to persist data.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SharedPrefsDemo(),
    );
  }
}

class SharedPrefsDemo extends StatefulWidget {
  // toggle this to turn persistence on/off
  final bool persistData = true;

  const SharedPrefsDemo({super.key});

  @override
  State<SharedPrefsDemo> createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  int _counter = 0;
  final TextEditingController _messageController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _loadData();
    _messageController.addListener(() { 
      _saveMessage();
    });
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      _messageController.text = (prefs.getString('message') ?? '');
    });
  }

  Future<void> _updateCounter(int inc) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter += inc;
      if (widget.persistData) {
        prefs.setInt('counter', _counter);
      }
    });
  }

  Future<void> _saveMessage() async {
    final prefs = await SharedPreferences.getInstance();
    if (widget.persistData) {
      prefs.setString('message', _messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _updateCounter(-1), 
                child: const Text('--')
              ),
              const SizedBox(width: 20),
              Text('Counter: $_counter'),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _updateCounter(1), 
                child: const Text('++')
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

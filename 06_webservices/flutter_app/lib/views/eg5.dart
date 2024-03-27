// Demonstrates:
// - Using asynchronous streams
// - Using the StreamBuilder widget

import 'package:flutter/material.dart';
import 'dart:async';

class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StreamExample()
    );
  }
}

class StreamExample extends StatefulWidget {
  const StreamExample({super.key});

  @override
  State createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  final StreamController<String> _itemController = StreamController<String>();
  final List<String> _items = [];
  int _count = 1;

  @override
  void dispose() {
    _itemController.close();
    super.dispose();
  }

  void _addItem() async {
    await Future.delayed(const Duration(seconds: 1));
    _itemController.sink.add('Item $_count');
    _count++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Example'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Add Item'),
          ),
          Expanded(
            child: StreamBuilder<String>(
              stream: _itemController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
    
                if (!snapshot.hasData) {
                  return const Center(child: Text('No items added yet.'));
                }
    
                _items.add(snapshot.data!);
    
                return ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) =>
                    ListTile(title: Text(_items[index]))
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

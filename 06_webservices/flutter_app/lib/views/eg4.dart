import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: MessageList(),
    );
  }
}


class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State createState() => _MessageListState();
}


class _MessageListState extends State<MessageList> {
  String _name = 'anonymous';

  // A reference to the cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  // Add a message to the cloud firestore
  void _sendMessage() {
    _firestore.collection('messages').add({
      'text': _messageController.text,
      'sender': _name,
      'timestamp': FieldValue.serverTimestamp(),
    });
    _messageController.clear();
  }


  // Delete all messages from the cloud firestore
  Future<void> _deleteAllMessages() async {
    final snapshot = await _firestore.collection('messages').get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Chat'),
        actions: [
          // An action to open a new screen to change the name
          IconButton(
            onPressed: () async {
              final name = await Navigator.of(context).push<String>(
                MaterialPageRoute(builder: (context) => const NameEditor()),
              );
              _name = name ?? _name;
            },
            icon: const Icon(Icons.person),
          ),

          // An action to delete all messages
          IconButton(
            onPressed: () => _deleteAllMessages(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          // StreamBuilder is a widget that builds itself based on the latest
          // snapshot of interaction with a specified asynchronous data source.
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .limit(50)
              .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final data = snapshot.data!.docs.reversed.map(
                (DocumentSnapshot doc) =>  doc.data() as Map<String, dynamic>
              ).toList();
              
              var listView = ListView.builder(
                controller: _scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index]['text']),
                  trailing: Text(
                    data[index]['sender'],
                    style: const TextStyle(color: Colors.grey)
                  )
                )
              );

              // Run this after the widget tree has been built
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Scroll to the bottom of the list view
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              });

              return Expanded(child: listView);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Enter your message...',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _sendMessage(),
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NameEditor extends StatefulWidget {
  const NameEditor({super.key});

  @override
  State createState() => _NameEditorState();
}


class _NameEditorState extends State<NameEditor> {
  final TextEditingController _nameController = TextEditingController();

  void _saveName() {
    Navigator.pop(context, _nameController.text);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onSubmitted: (_) => _saveName(),
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextButton(
              onPressed: () => _saveName(),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }


}

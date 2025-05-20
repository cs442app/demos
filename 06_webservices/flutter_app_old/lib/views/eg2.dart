// Demonstrates:
// - Integrating a simple RESTful web service
// - Sending and receiving JSON data

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:word_generator/word_generator.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App2',
      home: MichaelsList(),
    );
  }
}

// Displays a list of posts from a web service.
class MichaelsList extends StatefulWidget {
  final String baseUrl = 'http://localhost:5001/posts';

  const MichaelsList({super.key});

  @override
  State<StatefulWidget> createState() => _MichaelsListState();
}

class _MichaelsListState extends State<MichaelsList> {
  Future<List<dynamic>>? futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = _loadPosts();
  }

  Future<List<dynamic>> _loadPosts() async {
    final response = await http.get(Uri.parse(widget.baseUrl));
    final posts = json.decode(response.body);
    return posts;
  }

  Future<void> _refreshPosts() async {
    setState(() {
      futurePosts = _loadPosts();
    });
  }

  Future<void> _addPost() async {
    // POST request to /posts to create a new post
    await http.post(Uri.parse(widget.baseUrl), 
      // we'll be sending JSON data
      headers: {'Content-Type': 'application/json'},

      // encode the data appropriately
      body: jsonEncode({
        // random post content
        'title': WordGenerator().randomNoun(),
        'description': WordGenerator().randomSentence(5),
        'author': WordGenerator().randomName(),
      })
    );

    _refreshPosts();
  }

  Future<void> _editPost(Map<String, dynamic> post) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostEditor(post: post),
      ),
    );
    _refreshPosts();
  }

  Future<void> _deletePost(int id) async {
    // DELETE request to /post/:id to delete a post
    await http.delete(Uri.parse('${widget.baseUrl}/$id'));
    _refreshPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Michael's List"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshPosts(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addPost()
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futurePosts,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return Dismissible(
                  key: Key(post['id'].toString()),
                  onDismissed: (_) {
                    snapshot.data!.removeAt(index);
                    _deletePost(post['id']);
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: ListTile(
                    title: Text(post['title']!),
                    subtitle: Text(post['description']!),
                    trailing: Text(post['author']!),
                    onTap: () => _editPost(post as Map<String, dynamic>),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


// Allows the user to edit a post.
class PostEditor extends StatefulWidget {
  final String baseUrl = 'http://localhost:5001/posts';
  final Map<String, dynamic> post;

  const PostEditor({required this.post, super.key});

  @override
  State<StatefulWidget> createState() => _PostEditorState();
}

class _PostEditorState extends State<PostEditor> {
  final TextEditingController _titleField = TextEditingController();
  final TextEditingController _descriptionField = TextEditingController();
  final TextEditingController _authorField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleField.text = widget.post['title'];
    _descriptionField.text = widget.post['description'];
    _authorField.text = widget.post['author'];
  }

  _updatePost() async {
    // PUT request to /post/:id to update an existing post
    await http.put(Uri.parse('${widget.baseUrl}/${widget.post['id']}'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': _titleField.text,
        'description': _descriptionField.text,
        'author': _authorField.text,
      })
    );

    if (!mounted) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _titleField,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: _descriptionField,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextFormField(
              controller: _authorField,
              decoration: const InputDecoration(
                labelText: 'Author',
              ),
            ),
            ElevatedButton(
              onPressed: () => _updatePost(),
              child: const Text('Update')
            )
          ]
        ),
      ),
    );
  }
}

// Demonstrates:
// - Integrating a simple RESTful web service with authentication
// - Saving session tokens in shared preferences
// - Replacing the current screen with a new screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:word_generator/word_generator.dart';
import '../utils/sessionmanager.dart';


class App3 extends StatefulWidget {
  const App3({super.key});

  @override
  State<App3> createState() => _App3State();
}

class _App3State extends State<App3> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // use SessionManager to check if a user is already logged in
  Future<void> _checkLoginStatus() async {
    final loggedIn = await SessionManager.isLoggedIn();
    if (mounted) {
      setState(() {
        isLoggedIn = loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App3',
      // start at either the home or login screen
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}


/// Screen for logging in or registering a new user.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => _login(context),
                  child: const Text('Log in'),
                ),
                TextButton(
                  onPressed: () => _register(context),
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse('http://localhost:5001/login');
    final response = await http.post(url, 
      headers: {
        'Content-Type': 'application/json', 
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      // Successful login. Save the session token or user info.

      // parse the session token from the response header
      // final sessionToken = response.headers['set-cookie']!.split(';')[0];
      final sessionToken = jsonDecode(response.body)['access_token'];
      await SessionManager.setSessionToken(sessionToken);

      if (!context.mounted) return;

      // go to the main screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ));
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  Future<void> _register(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse('http://localhost:5001/register');
    final response = await http.post(url, 
      headers: {
        'Content-Type': 'application/json', 
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      // Successful registration. Treat this like a login.

      // parse the session token from the response header
      // final sessionToken = response.headers['set-cookie']!.split(';')[0];
      final sessionToken = jsonDecode(response.body)['access_token'];
      await SessionManager.setSessionToken(sessionToken);

      if (!context.mounted) return;

      // go to the main screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ));
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }
}


/// Very similar to main screen in eg2.dart, but with authentication.
class HomeScreen extends StatefulWidget {
  final String baseUrl = 'http://localhost:5001/posts';

  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    await http.post(Uri.parse(widget.baseUrl), 
      headers: {
        'Content-Type': 'application/json',

        // need session token to create a post
        'Authorization': 'Bearer ${await SessionManager.getSessionToken()}',
      },

      body: jsonEncode({
        'title': WordGenerator().randomNoun(),
        'content': WordGenerator().randomSentence(5),
        'author': WordGenerator().randomName(),
      })
    );

    _refreshPosts();
  }


  Future<void> _deletePost(int id) async {
    await http.delete(Uri.parse('${widget.baseUrl}/$id'),
      headers: {
        'Content-Type': 'application/json',

        // need session token to delete a post
        'Authorization': 'Bearer ${await SessionManager.getSessionToken()}',
      },
    );
    _refreshPosts();
  }

  Future<void> _doLogout() async {
    // get rid of the session token
    await SessionManager.clearSession();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ));
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _doLogout()
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
                    subtitle: Text(post['content']!),
                    trailing: Text(post['author']!),
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

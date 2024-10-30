// Demonstrates:
// - Consuming a simple third-party REST API

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class App4 extends StatelessWidget {
  const App4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App5',
      home: NewsClient(),
    );
  }
}

// Displays recent news from the News API REST service
class NewsClient extends StatefulWidget {
  final String url = 'https://newsapi.org/v2/top-headlines?country=us';
  final String apiKey = '5c345cb63a3c4046a363977eaff43011';
  
  const NewsClient({super.key});

  @override
  State createState() => _NewsClientState();
}


class _NewsClientState extends State<NewsClient> {
  Future<List<dynamic>>? futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = _loadPosts();
  }

  Future<List<dynamic>> _loadPosts() async {
    final response = await http.get(
      Uri.parse('${widget.url}&apiKey=${widget.apiKey}'));
    final posts = json.decode(response.body);

    if (posts['status'] != 'ok') {
      throw Exception('Failed to load posts: ${posts['message']}');
    }

    return posts['articles'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Client'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(
                    article['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(article['description'] ?? ''),
                      const SizedBox(height: 8),
                      Text(
                        article['author'] ?? 'Unknown',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Divider(),
                    ],
                  )

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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Fetch data from API
            final posts = await fetchPosts();
            // Navigate to PostPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostPage(posts: posts),
              ),
            );
          },
          child: const Text('Fetch Posts'),
        ),
      ),
      bottomNavigationBar: const Card(
        // child: Text('Ready to fetch posts?'),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Ready to fetch posts?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<List<Member>> fetchPosts() async {
    final response = await http.get(
        Uri.parse('api-url'),
        headers: {
          "Authorization":
              "Bearer token"
        });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load posts. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  }
}

class Member {
  final int id;
  final String username;
  final String name;

  Member({required this.id, required this.username, required this.name});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      username: json['username'],
      name: json['name'],
    );
  }
}

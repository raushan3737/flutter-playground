import 'package:flutter/material.dart';
import 'home_page.dart';

class PostPage extends StatelessWidget {
  final List<Member> posts;

  const PostPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            child: ListTile(
              title: Text(post.username),
              subtitle: Text(post.name),
            ),
          );
        },
      ),
    );
  }
}

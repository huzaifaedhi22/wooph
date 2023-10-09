import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  String caption;
  String url;

  PostCard({
    required this.caption,
    required this.url,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6zUM6Bo8UCvy0hOn0K0EG0SEoFF7tq90yObG8dGWoYQ&s'),
            Text(
              widget.caption,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

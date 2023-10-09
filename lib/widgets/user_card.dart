import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  String name;

  UserCard({
    required this.name,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.teal,
        ),
        child: Column(
          children: [
            Icon(Icons.verified_user_rounded),
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            TextButton(onPressed: () {}, child: Text('Follow')),
          ],
        ),
      ),
    );
  }
}

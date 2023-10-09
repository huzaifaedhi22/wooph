import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/data/repository/db_queries.dart';
import 'package:social_media_app/widgets/post_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repository/auth_repo.dart';
import '../../widgets/user_card.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({super.key});

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

TextEditingController postController = TextEditingController();
Uint8List? _pickedImageBytes;

final dbQueryImpl db = GetIt.instance<dbQueryImpl>();
final AuthServiceImpl auth = GetIt.instance<AuthServiceImpl>();

class _FindFriendsState extends State<FindFriends> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildPostsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class buildPostsList extends StatelessWidget {
  const buildPostsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: db.fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No users available.');
        } else {
          final users = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: users!.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserCard(
                name: user['name'],
              );
            },
          );
        }
      },
    );
  }
}

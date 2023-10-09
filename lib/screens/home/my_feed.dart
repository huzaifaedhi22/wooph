import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/data/repository/db_queries.dart';
import 'package:social_media_app/widgets/post_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repository/auth_repo.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

TextEditingController postController = TextEditingController();
Uint8List? _pickedImageBytes;

final dbQueryImpl db = GetIt.instance<dbQueryImpl>();
final AuthServiceImpl auth = GetIt.instance<AuthServiceImpl>();

class _MyFeedState extends State<MyFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildPostsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print('djeeu');
          // dbQuery db = dbQuery();
          // db.fetchPosts();
          _showDialog(context);
        },
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Whats on your mind?'),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: postController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Write something...',
                        ),
                      ),
                    ),
                    if (_pickedImageBytes != null)
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05, height: MediaQuery.of(context).size.width * 0.05, child: Image.memory(_pickedImageBytes!)) // Display the picked image
                    else
                      const Text(''),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    db.createPost(auth.client.auth.currentUser!.id.toString(), postController.text, 'https://t4.ftcdn.net/jpg/01/43/42/83/360_F_143428338_gcxw3Jcd0tJpkvvb53pfEztwtU9sxsgT.jpg');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Post'),
                ),
                IconButton(
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

                    if (picked != null) {
                      final bytes = picked.files.first.bytes;
                      setState(() {
                        _pickedImageBytes = bytes;
                      });
                    }
                  },
                  icon: const Icon(Icons.photo_camera),
                ),
              ],
            );
          },
        );
      },
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
      future: db.fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No posts available.');
        } else {
          final posts = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: posts!.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(
                caption: post['text'] ?? 'No Caption',
                url: post['image_url'] ?? 'missing url',
              );
            },
          );
        }
      },
    );
  }
}

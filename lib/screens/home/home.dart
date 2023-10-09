import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:social_media_app/screens/home/find_friends.dart';
import 'package:social_media_app/screens/home/my_feed.dart';
import 'package:social_media_app/shared_widgets.dart';
import 'package:file_picker/file_picker.dart';

import '../../Constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Widget> views = const [
  Center(child: MyFeed()),
  Center(
    child: FindFriends(),
  ),
  Center(
    child: Text('Settings'),
  ),
];

TextEditingController postController = TextEditingController();
int selectedIndex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      appBar: AppBar(
        title: const Text('Wooph'),
        backgroundColor: Constants.kDarkBlueColor,
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SideNavigationBar(
              initiallyExpanded: false,
              selectedIndex: selectedIndex,
              items: const [
                SideNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                ),
                SideNavigationBarItem(
                  icon: Icons.person,
                  label: 'Profile',
                ),
                SideNavigationBarItem(
                  icon: Icons.settings,
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}

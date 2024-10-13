import 'package:ai_eng_tutor/pages/home_page.dart';
import 'package:ai_eng_tutor/pages/level_page.dart';
import 'package:ai_eng_tutor/pages/profile_page.dart';
import 'package:ai_eng_tutor/pages/vocab_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  int _currentIndex = 0;

  // Pages for each tab in the bottom navigation bar
  final List<Widget> _pages = [
    HomePage(),
    VocabPage(),
    LevelPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Switch between pages
        children: _pages,
      ),
      bottomNavigationBar: SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.purple,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.chat),
          title: Text("Chat"),
          selectedColor: Colors.orange,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.notifications),
          title: Text("Notifications"),
          selectedColor: Colors.teal,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: Colors.blue,
        ),
      ],
    ),
    );
  }
}



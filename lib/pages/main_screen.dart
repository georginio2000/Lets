import 'package:flutter/material.dart';
import '../widgets/home/navigation_bar.dart'; // Import the CustomNavigationBar widget
import 'package:project/pages/home_page.dart';
import 'package:project/pages/friends_page.dart';
import 'package:project/pages/add_page.dart';
import 'package:project/pages/map_page.dart';
import 'package:project/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Current selected page index

  // List of pages corresponding to each navigation bar icon
  final List<Widget> _pages = [
    const HomePage(),
    const FriendsPage(),
    const AddPage(),
    const MapPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Display the selected page
        children: _pages, // List of all pages
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex, // Current selected index
        onIconTapped: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index
          });
        },
      ),
    );
  }
}

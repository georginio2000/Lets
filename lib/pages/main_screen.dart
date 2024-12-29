import 'package:flutter/material.dart';
import '../widgets/general/navigation_bar.dart'; // Import the CustomNavigationBar widget
import 'package:project/pages/home_page.dart';
import 'package:project/pages/friends_page.dart';
import 'package:project/pages/add_page.dart';
import 'package:project/pages/map_page.dart';
import 'package:project/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Current selected page index

  // List of pages corresponding to each navigation bar icon
  final List<Widget> _pages = [
    HomePage(),
    FriendsPage(),
    Placeholder(), // Placeholder for AddPage to navigate separately
    MapPage(),
    ProfilePage(),
  ];

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPage(),
      ),
    ).then((_) {
      // Optional: Perform any action when returning from AddPage, if needed
      setState(() {
        _selectedIndex = 0; // Return to the HomePage by default
      });
    });
  }

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
          if (index == 2) {
            // Navigate to AddPage
            _navigateToAddPage(context);
          } else {
            setState(() {
              _selectedIndex = index; // Update selected index
            });
          }
        },
      ),
    );
  }
}

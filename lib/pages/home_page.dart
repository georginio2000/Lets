import 'package:flutter/material.dart';
import '../widgets/home/navigation_bar.dart'; // Import your CustomNavigationBar

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // To track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Page Index: $_selectedIndex"), // Show the current index
      ),
      bottomNavigationBar: CustomNavigationBar( // Use CustomNavigationBar
        selectedIndex: _selectedIndex,
        onIconTapped: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}

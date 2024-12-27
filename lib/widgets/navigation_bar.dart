import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // To track the selected icon/page

  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Friends Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Add Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Map Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Bar Example'),
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: NavigationBar(
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

class NavigationBar extends StatelessWidget {
  final int selectedIndex; // Current selected index
  final Function(int) onIconTapped; // Callback for icon taps

  NavigationBar({required this.selectedIndex, required this.onIconTapped});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Set the height of the navigation bar here
      child: BottomAppBar(
        color: Color(0xFF468585), // Background color of the navigation bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute items
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                'assets/HOME_ICON.svg', // Path to your SVG file
                height: 50,             // Set the height
                color: selectedIndex == 0 ? Colors.white : Colors.black, // Change color based on selected index
              ),
              onPressed: () {
                onIconTapped(0); // Pass the index to the callback
              },
              tooltip: 'Home',
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/FREINDS_ICON.svg', // Path to your SVG file
                height: 30,             // Set the height
                color: selectedIndex == 1 ? Colors.white : Colors.black, // Change color based on selected index
              ),
              onPressed: () {
                onIconTapped(1); // Pass the index to the callback
              },
              tooltip: 'Friends',
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/ADD_ICON.svg', // Path to your SVG file
                height: 30,             // Set the height
                color: selectedIndex == 2 ? Colors.white : Colors.black, // Change color based on selected index
              ),
              onPressed: () {
                onIconTapped(2); // Pass the index to the callback
              },
              tooltip: 'Add',
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/MAP_ICON_APPBAR.svg', // Path to your SVG file
                height: 30,             // Set the height
                color: selectedIndex == 3 ? Colors.white : Colors.black, // Change color based on selected index
              ),
              onPressed: () {
                onIconTapped(3); // Pass the index to the callback
              },
              tooltip: 'Map',
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/PROFILE_ICON.svg', // Path to your SVG file
                height: 30,             // Set the height
                color: selectedIndex == 4 ? Colors.white : Colors.black, // Change color based on selected index
              ),
              onPressed: () {
                onIconTapped(4); // Pass the index to the callback
              },
              tooltip: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

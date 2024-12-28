import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget { // Rename to CustomNavigationBar
  final int selectedIndex; // Current selected index
  final Function(int) onIconTapped; // Callback for icon taps

  CustomNavigationBar({required this.selectedIndex, required this.onIconTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Set the height of the navigation bar
      decoration: const BoxDecoration(
        color: Color(0xFF468585), // Background color
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black), // Optional border
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute items
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/HOME_ICON.svg', // Path to your SVG file
              height: 30,             // Set the height
              colorFilter: ColorFilter.mode(
                selectedIndex == 0 ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              onIconTapped(0); // Pass the index to the callback
            },
            tooltip: 'Home',
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/FREINDS_ICON.svg', // Path to your SVG file
              height: 30,
              colorFilter: ColorFilter.mode(
                selectedIndex == 1 ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              onIconTapped(1);
            },
            tooltip: 'Friends',
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/ADD_ICON.svg',
              height: 30,
              colorFilter: ColorFilter.mode(
                selectedIndex == 2 ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              onIconTapped(2);
            },
            tooltip: 'Add',
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/MAP_ICON_APPBAR.svg',
              height: 30,
              colorFilter: ColorFilter.mode(
                selectedIndex == 3 ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              onIconTapped(3);
            },
            tooltip: 'Map',
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/PROFILE_ICON.svg',
              height: 30,
              colorFilter: ColorFilter.mode(
                selectedIndex == 4 ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              onIconTapped(4);
            },
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}

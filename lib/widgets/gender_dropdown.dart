import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gender Dropdown Menu'),
        ),
        body: Center(
          child: GenderDropdownMenu(),
        ),
      ),
    );
  }
}

class GenderDropdownMenu extends StatefulWidget {
  @override
  _GenderDropdownMenuState createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  String? selectedValue; // Variable to hold the selected value
  final List<String> items = ['MALE', 'FEMALE', 'OTHER']; // Dropdown items

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Width of the dropdown box
      height: 45, // Height of the dropdown box
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA), // Background color of the box
        border: Border.all(color: Colors.black, width: 1), // Border around the main box
        borderRadius: BorderRadius.circular(2), // Rounded corners for a modern look
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: const Text(
            'GENDER',
            style: TextStyle(fontSize: 14, color: Colors.black38), // Placeholder text style
          ), // Placeholder text
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black), // Dropdown item text style
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue; // Update the selected value
            });
          },
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black, // Dropdown arrow icon color
          ),
          dropdownColor: const Color(0xFFE5E1DA), // Background color of the dropdown menu
          style: const TextStyle(color: Colors.black, fontSize: 14), // Style for dropdown text
        ),
      ),
    );
  }
}

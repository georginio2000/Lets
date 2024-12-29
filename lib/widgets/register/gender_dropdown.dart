import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gender Dropdown Menu'),
        ),
        body: const Center(
          child: GenderDropdownMenu(),
        ),
      ),
    );
  }
}

class GenderDropdownMenu extends StatefulWidget {
  final ValueChanged<String?>? onChanged; // Callback for changes

  const GenderDropdownMenu({super.key, this.onChanged});

  @override
  _GenderDropdownMenuState createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  String? selectedValue;
  final List<String> items = ['MALE', 'FEMALE', 'OTHER'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: const Text(
            'GENDER',
            style: TextStyle(fontSize: 14, color: Colors.black38),
          ), // Placeholder text
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue); // Trigger the callback
            }
          },
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          dropdownColor: const Color(0xFFE5E1DA),
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}

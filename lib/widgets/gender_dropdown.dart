import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['MALE', 'FEMALE', 'OTHER'];

void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: GenderDropdownMenuExample(),
        ),
      ),
    );
  }
}

class GenderDropdownMenuExample extends StatefulWidget {
  const GenderDropdownMenuExample({super.key});

  @override
  State<GenderDropdownMenuExample> createState() =>
      _GenderDropdownMenuExampleState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _GenderDropdownMenuExampleState extends State<GenderDropdownMenuExample> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      // Customize the main box (input field) here:
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Enable filling the background
        fillColor: const Color(0xFFE5E1DA), // Set the background color
        border: OutlineInputBorder(
          // Customize the border
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Colors.black, // Border color for the main box
            width: 1.0, // Border width for the main box
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 12.0), // Adjust padding
      ),
      // Customize the dropdown menu (the list of items) here:
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFFE5E1DA)), // Background color for the dropdown
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: const BorderSide(
              color: Colors.black, // Border color for the dropdown
              width: 1.0, // Border width for the dropdown
            ),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(8.0),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0.0)), // Remove padding
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: menuEntries
          .map(
            (entry) => DropdownMenuEntry<String>(
          value: entry.value,
          label: entry.label,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0)), // Add padding to each item
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFFE5E1DA)), // Background color for each item
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: const BorderSide(
                  color: Colors.black, // Border color for each item
                  width: 1.0, // Border width for each item
                ),
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}
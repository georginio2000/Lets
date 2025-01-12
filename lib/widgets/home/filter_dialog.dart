import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final List<String> allTags; // Available tags for filtering
  final List<String> initialSelectedTags; // Tags initially selected (if any)
  final Function(List<String>) onApply; // Callback to return selected tags

  const FilterDialog({
    super.key,
    required this.allTags,
    required this.initialSelectedTags,
    required this.onApply,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late List<String> selectedTags; // Tags selected by the user
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedTags = List.from(widget.initialSelectedTags); // Initialize selected tags
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // Rounded corners for the dialog
      ),
      child: Container(
        width:400, // Fixed width for the dialog
        decoration: BoxDecoration(
          color: const Color(0xFF9CC4C4), // Custom background color
          border: Border.all(color: Colors.black, width: 2), // Black border
          borderRadius: BorderRadius.circular(4), // Match the border radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'FILTERS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E1DA), // Set the fill color
                  borderRadius: BorderRadius.circular(5), // Rounded corners for the dropdown button
                ),
                child:DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width * 0.6, // Make the box wider
                    enableFilter: true, // Enable filtering
                    requestFocusOnTap: true, // Automatically focus search input on tap
                    controller: searchController, // Attach the controller for the search box
                    hintText: "CHOOSE TAGS", // Placeholder text
                    textStyle: TextStyle(
                      color: Colors.teal.shade900, // Text color for the box
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (String? newTag) {
                      if (newTag != null && !selectedTags.contains(newTag)) {
                        setState(() {
                          selectedTags.add(newTag); // Add the selected tag
                        });
                      }
                    },
                    dropdownMenuEntries: widget.allTags
                        .map((tag) => DropdownMenuEntry<String>(
                      value: tag,
                      label: tag,
                    ))
                        .toList(),
                  ),
                ),
                  const SizedBox(height: 10),
                  // Display selected tags as chips
                  Wrap(
                    spacing: 8.0, // Spacing between chips
                    runSpacing: 8.0, // Spacing between rows of chips
                    children: selectedTags.map((tag) {
                      return Container(
                        height: 20, // Set custom chip height
                        decoration: BoxDecoration(
                          color: const Color(0xFF468585), // Chip background color
                          borderRadius: BorderRadius.circular(12), // Chip rounded corners
                          border: Border.all(color: Colors.black, width: 1), // Chip border
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tag,
                              style: const TextStyle(color: Colors.white, fontSize: 12), // Text color
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTags.remove(tag); // Remove the tag
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.black, // Icon color
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Row(
              children:[
                const SizedBox(width: 200),
                ElevatedButton(
                onPressed: () {
                  widget.onApply(selectedTags); // Pass selected tags to callback
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF50B498), // Custom button color
                  side: const BorderSide(color: Colors.black, width: 1), // Add border to button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // Custom button radius
                  ),
                ),
                child: const Text(
                  'SEARCH',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ]
            )
          ],
        ),
      ),
    );
  }
  }
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FilterDialog Test',
      home: FilterDialogTestScreen(),
    );
  }
}

class FilterDialogTestScreen extends StatefulWidget {
  const FilterDialogTestScreen({super.key});

  @override
  State<FilterDialogTestScreen> createState() => _FilterDialogTestScreenState();
}

class _FilterDialogTestScreenState extends State<FilterDialogTestScreen> {
  List<String> selectedTags = []; // Tags selected by the user

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          allTags: const ['Sports', 'Music', 'Art', 'Technology', 'Travel', 'Food'],
          initialSelectedTags: selectedTags,
          onApply: (List<String> tags) {
            setState(() {
              selectedTags = tags; // Update the selected tags
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilterDialog Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _openFilterDialog,
              child: const Text('Open Filter Dialog'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selected Tags:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: selectedTags.map((tag) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        selectedTags.remove(tag); // Allow removal from main page
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

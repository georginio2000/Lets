import 'package:flutter/material.dart';

class SearchWithFilter extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;

  const SearchWithFilter({
    super.key,
    required this.searchController,
    required this.onSearchPressed,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Input Box
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E1DA),
              borderRadius: BorderRadius.circular(2), // Add border radius
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'SEARCH ACTIVITY ID',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10), // Space between input and filter button

        // Filter Button
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF50B498),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_alt),
            color: Colors.black,
            iconSize: 24,
            onPressed: onFilterPressed,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SearchActivityBox extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;

  const SearchActivityBox({
    super.key,
    required this.searchController,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Request focus for the TextField when the box is tapped
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: 45, // Fixed height for the search box
        width: double.infinity, // Full width of parent
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
        child: Stack(
          children: [
            // Search Icon Button
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: onSearchPressed, // Trigger search action
              ),
            ),
            // TextField covering the rest of the box
            Positioned.fill(
              left: 50, // Ensure the TextField starts after the search icon
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'SEARCH ACTIVITY ID',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                  contentPadding: EdgeInsets.only(top: -2, left: 2),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

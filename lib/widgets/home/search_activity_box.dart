import 'package:flutter/material.dart';

class SearchActivityBox extends StatelessWidget {
  final TextEditingController searchController;

  const SearchActivityBox({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

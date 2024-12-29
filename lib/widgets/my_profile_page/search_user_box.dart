import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Για το εικονίδιο αναζήτησης

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchPressed;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 30, // Set fixed height
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA), // Ανοιχτό μπεζ φόντο
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 5,
            offset: const Offset(2, 4), // Σκιά
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black, // Χρώμα του κειμένου που πληκτρολογείται
              ),
              decoration: const InputDecoration(
                hintText: "SEARCH USERNAME",
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey, // Αχνό γκρι χρώμα για το hint text
                ),
                border: InputBorder.none, // Αφαίρεση του default περιγράμματος
                contentPadding: EdgeInsets.symmetric(
                  vertical: 11, // Center vertically
                  horizontal: 10, // Padding on the left and right
                ),
              ),
              textAlignVertical: TextAlignVertical.center, // Ensures text stays centered
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/SEARCH_ICON.svg', // Εικονίδιο αναζήτησης
              width: 50,
              height: 20,
            ),
            onPressed: onSearchPressed,
          ),
        ],
      ),
    );
  }
}

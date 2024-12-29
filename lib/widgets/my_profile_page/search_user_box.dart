import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      height: 30, // Fixed height
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA),
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.black, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            blurRadius: 5,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // TextField
          Positioned(
            left: 10,
            top: -8,
            right: 40,
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: "SEARCH USERNAME",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8, // Center vertically
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: GestureDetector(
              onTap: onSearchPressed,
              child: SizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/SEARCH_ICON.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

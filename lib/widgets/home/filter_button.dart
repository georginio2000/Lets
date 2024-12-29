import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatefulWidget {
  final VoidCallback onFilterPressed;

  const FilterButton({
    super.key,
    required this.onFilterPressed,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  Color _filterButtonColor = const Color(0xFF50B498); // Default color

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onFilterPressed,
      onHighlightChanged: (isPressed) {
        setState(() {
          _filterButtonColor = isPressed
              ? const Color(0xFF3E8C74) // Pressed color
              : const Color(0xFF50B498); // Default color
        });
      },
      borderRadius: BorderRadius.circular(5), // For ripple effect boundary
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: _filterButtonColor, // Dynamic color
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0), // Adjust the padding to move the icon down
            child: SvgPicture.asset(
              'assets/FILTER_ICON.svg', // Path to your SVG file
              height: 34, // Set the height
            ),
          ),
        ),
      ),
    );
  }
}

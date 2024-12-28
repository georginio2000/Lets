import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF50B498),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0), // Στρογγυλεμένες γωνίες
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/settings_icon.svg', // Διαδρομή στο SVG icon στα assets
          height: 24, // Ύψος του icon
          width: 24, // Πλάτος του icon
        ),
        iconSize: 30,
        onPressed: onPressed,
      ),
    );
  }
}

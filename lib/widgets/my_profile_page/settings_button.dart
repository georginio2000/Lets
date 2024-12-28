import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF50B498),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
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
        icon: const Icon(Icons.settings, color: Colors.black),
        iconSize: 30,
        onPressed: onPressed,
      ),
    );
  }
}

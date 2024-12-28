import 'package:flutter/material.dart';

class AddFriendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFriendButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF50B498), // Background color
        border: Border.all(color: Colors.black, width: 1), // Border
        borderRadius: BorderRadius.circular(0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.person_add, color: Colors.black),
        iconSize: 24,
        onPressed: onPressed,
      ),
    );
  }
}

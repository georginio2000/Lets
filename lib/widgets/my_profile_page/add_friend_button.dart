import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFriendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFriendButton({
    super.key,
    required this.onPressed,
  });

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
        icon: SvgPicture.asset(
          'assets/add_friend_icon.svg', // Path to the SVG icon
          fit: BoxFit.contain,
          width: 24,
          height: 24,
        ),
        iconSize: 24,
        onPressed: onPressed,
      ),
    );
  }
}

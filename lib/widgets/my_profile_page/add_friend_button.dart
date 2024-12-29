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
        color: const Color(0xFF50B498),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/add_friend_iconn.svg',
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

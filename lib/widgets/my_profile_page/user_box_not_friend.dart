import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFriendWidget extends StatelessWidget {
  final String username;
  final VoidCallback onAddFriendPressed;

  const AddFriendWidget({
    super.key,
    required this.username,
    required this.onAddFriendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Stack(
        children: [
          // Εικόνα προφίλ
          Positioned(
            left: 10,
            top: 10,
            child: SvgPicture.asset(
              'assets/EXTRA_SMALL_PROFILE.svg',
              width: 30,
              height: 30,
            ),
          ),
          // Όνομα χρήστη
          Positioned(
            left: 50,
            top: 14,
            child: Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 3,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/ADD_FRIEND_ICON.svg',
                width: 35,
                height: 35,
              ),
              onPressed: onAddFriendPressed,
            ),
          ),
        ],
      ),
    );
  }
}

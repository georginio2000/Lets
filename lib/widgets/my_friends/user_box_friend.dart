import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/pages/profile_user_my_friend.dart';

class AddFriendWidget extends StatelessWidget {
  final String username;
  final String uid; // Το UID του χρήστη
  final VoidCallback onAddFriendPressed;

  const AddFriendWidget({
    super.key,
    required this.username,
    required this.uid,
    required this.onAddFriendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(uid: uid),
          ),
        );
      },
      child: Container(
        width: 360,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
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
            Positioned(
              left: 10,
              top: 10,
              child: SvgPicture.asset(
                'assets/EXTRA_SMALL_PROFILE.svg',
                width: 30,
                height: 30,
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}

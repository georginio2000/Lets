import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/pages/profile_user_my_friend.dart'; // Η σελίδα του χρήστη που φτιάξαμε

class AddFriendWidget extends StatelessWidget {
  final String username;
  final String uid; // Το UID του χρήστη
  final VoidCallback onAddFriendPressed;

  const AddFriendWidget({
    super.key,
    required this.username,
    required this.uid, // Προσθήκη του UID ως παράμετρο
    required this.onAddFriendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Πλοήγηση στη σελίδα του χρήστη
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(uid: uid), // Περνάμε το UID στον χρήστη
          ),
        );
      },
      child: Container(
        width: 360,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white, // Χρώμα του φόντου
          borderRadius: BorderRadius.circular(0), // Στρογγυλεμένες γωνίες
          border: Border.all(color: Colors.black, width: 1.0), // Πλαίσιο
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
              left: 10, // Απόσταση από τα αριστερά
              top: 10, // Απόσταση από πάνω
              child: SvgPicture.asset(
                'assets/EXTRA_SMALL_PROFILE.svg',
                width: 30,
                height: 30,
              ),
            ),
            // Όνομα χρήστη
            Positioned(
              left: 50, // Απόσταση από τα αριστερά
              top: 14, // Απόσταση από πάνω
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

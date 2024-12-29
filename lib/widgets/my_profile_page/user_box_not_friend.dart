import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Χρειάζεται για τα SVG αρχεία

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
          // Εικονίδιο προσθήκης φίλου
          Positioned(
            right: 10, // Απόσταση από τα δεξιά
            top: 3, // Απόσταση από πάνω
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/ADD_FRIEND_ICON.svg',
                width: 35, // Αυξημένο πλάτος
                height: 35, // Αυξημένο ύψος
              ),
              onPressed: onAddFriendPressed,
            ),
          ),
        ],
      ),
    );
  }
}

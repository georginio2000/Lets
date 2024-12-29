import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  Future<String> _getUsername() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        return snapshot.data()?['username'] ?? 'Unknown User';
      }
    }
    return 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUsername(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Text('Error loading username');
        }
        final String username = snapshot.data ?? 'Unknown User';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE0E0E0), // Light grey background
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: SvgPicture.asset(
                'assets/profile_pic.svg', // Διαδρομή στο SVG icon στα assets
                width: 80,
                height: 80,
                fit: BoxFit.contain, // Διασφαλίζει ότι το SVG χωράει σωστά
              ),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

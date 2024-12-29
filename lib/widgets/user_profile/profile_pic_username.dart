import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidgetUser extends StatelessWidget {
  final String uid;

  const ProfileWidgetUser({super.key, required this.uid});

  Future<Map<String, dynamic>> _getUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      return snapshot.data() ?? {};
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Error loading user data',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        }

        final Map<String, dynamic> userData = snapshot.data!;
        final String username = userData['username'] ?? 'Unknown User';
        final String profilePicUrl = userData['profilePicUrl'] ?? '';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE0E0E0),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: profilePicUrl.isNotEmpty
                  ? ClipOval(
                child: Image.network(
                  profilePicUrl,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              )
                  : SvgPicture.asset(
                'assets/profile_pic.svg',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
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

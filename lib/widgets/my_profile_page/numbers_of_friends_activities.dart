import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsActivitiesWidget extends StatelessWidget {
  const FriendsActivitiesWidget({super.key});

  Future<int> _getFriendsCount() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        final List<dynamic>? friends = snapshot.data()?['friends'];
        return friends?.length ?? 0;
      }
    }
    return 0;
  }

  Future<int> _getActivitiesCount() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('activities')
          .where('createdBy', isEqualTo: user.uid)
          .get();

      return snapshot.docs.length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Activities Section
        FutureBuilder<int>(
          future: _getActivitiesCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildStatisticBox('ACTIVITIES', '...');
            }
            if (snapshot.hasError) {
              return _buildStatisticBox('ACTIVITIES', 'Error');
            }
            return _buildStatisticBox('ACTIVITIES', snapshot.data.toString());
          },
        ),
        // Add space between sections
        const SizedBox(width: 130),
        // Friends Section
        FutureBuilder<int>(
          future: _getFriendsCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildStatisticBox('FRIENDS', '...');
            }
            if (snapshot.hasError) {
              return _buildStatisticBox('FRIENDS', 'Error');
            }
            return _buildStatisticBox('FRIENDS', snapshot.data.toString());
          },
        ),
      ],
    );
  }

  Widget _buildStatisticBox(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, // Center align the text horizontally
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center, // Ensures the number is centered
        ),
      ],
    );
  }
}

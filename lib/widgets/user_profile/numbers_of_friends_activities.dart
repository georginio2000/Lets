import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_button.dart';

class FriendsActivitiesWidget extends StatelessWidget {
  final String uid;
  final double spacing;

  const FriendsActivitiesWidget({super.key, required this.uid, this.spacing = 20});

  Future<int> _getFriendsCount() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      final List<dynamic>? friends = snapshot.data()?['friends'];
      return friends?.length ?? 0;
    }
    return 0;
  }

  Future<int> _getActivitiesCount() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('activities')
        .where('createdBy', isEqualTo: uid)
        .get();

    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        const SizedBox(width: 40),
        // Custom Button Section
        CustomButton(
          onPressed: () {
            print('Custom button pressed!');
          },
        ),
        const SizedBox(width: 40),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

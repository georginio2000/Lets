import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BioBoxUser extends StatelessWidget {
  final String uid;

  const BioBoxUser({super.key, required this.uid});

  Future<String> _fetchBio() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data()?['bio'] ?? 'No bio available';
    }
    return 'No bio available';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchBio(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Loading...'),
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Error loading bio'),
          );
        } else {
          final String bio = snapshot.data ?? 'No bio available';

          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Text(
              bio,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BioBox extends StatelessWidget {
  const BioBox({super.key});

  Future<String> _fetchBio() async {
    // Λήψη του αποθηκευμένου bio από το Firebase
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['bio'] ?? 'No bio available';
      }
    }
    return 'No bio available'; // Default μήνυμα αν δεν υπάρχει bio
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
              maxWidth: 300, // Μπορείς να το ρυθμίσεις ανάλογα
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

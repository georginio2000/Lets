import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'info_box.dart';

class ViewYourInfoDialog extends StatelessWidget {
  const ViewYourInfoDialog({super.key});

  Future<Map<String, dynamic>?> _fetchUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return doc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Error fetching user info",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          final userInfo = snapshot.data!;
          final usernameController = TextEditingController();
          final emailController = TextEditingController();
          final ageController = TextEditingController();
          final genderController = TextEditingController();
          final phoneController = TextEditingController();
          final firstnameController = TextEditingController();
          final lastnameController = TextEditingController();

          return Center(
            child: Container(
              width: 367,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF9CC4C4),
                borderRadius: BorderRadius.circular(0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Username",
                      initialValue: userInfo['username'] ?? 'N/A',
                      controller: usernameController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Email",
                      initialValue: userInfo['email'] ?? 'N/A',
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Age",
                      initialValue: userInfo['age']?.toString() ?? 'N/A',
                      controller: ageController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Gender",
                      initialValue: userInfo['gender'] ?? 'N/A',
                      controller: genderController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Phone",
                      initialValue: userInfo['phone'] ?? 'N/A',
                      controller: phoneController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "First Name",
                      initialValue: userInfo['firstname'] ?? 'N/A',
                      controller: firstnameController,
                    ),
                    const SizedBox(height: 10),
                    InfoBox(
                      labelText: "Last Name",
                      initialValue: userInfo['lastname'] ?? 'N/A',
                      controller: lastnameController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

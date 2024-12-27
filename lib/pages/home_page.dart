import 'package:flutter/material.dart';
import 'package:project/utils/storage_services.dart'; // Import your Firebase utility file

class HomePage extends StatelessWidget {
  final String userId = 'user123'; // Replace with the actual user ID from authentication or other sources

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'), // Optional AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is an empty page.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20), // Space between text and button
            ElevatedButton(
              onPressed: () async {
                // Call the function to upload user profile photo
                String? imageUrl = await FirebaseUtils.uploadUserProfilePicture(userId);

                if (imageUrl != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile photo uploaded successfully!'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to upload photo.'),
                    ),
                  );
                }
              },
              child: Text('Upload Profile Photo'),
            ),
          ],
        ),
      ),
    );
  }
}

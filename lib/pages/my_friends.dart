import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/my_profile_page/add_friend_button.dart'; // Import για το Add Friend κουμπί
import '../widgets/my_profile_page/add_friend.dart'; // Import για το Add Friend popup
import '../widgets/my_friends/user_box_friend.dart'; // Import για το AddFriendWidget

class MyFriendsPage extends StatelessWidget {
  const MyFriendsPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchFriends() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    // Ανάκτηση της λίστας φίλων του χρήστη από το Firebase
    final DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final List<dynamic> friendsIds = userDoc.data()?['friends'] ?? [];

    if (friendsIds.isEmpty) {
      return [];
    }

    // Ανάκτηση πληροφοριών για κάθε φίλο
    final List<Map<String, dynamic>> friends = [];
    for (String friendId in friendsIds) {
      final DocumentSnapshot<Map<String, dynamic>> friendDoc =
      await FirebaseFirestore.instance.collection('users').doc(friendId).get();

      if (friendDoc.exists) {
        friends.add({
          'username': friendDoc.data()?['username'] ?? 'Unknown',
        });
      }
    }

    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Χρώμα φόντου
      body: Stack(
        children: [
          // Scrollable περιοχή
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchFriends(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Failed to load friends.",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                );
              }

              final List<Map<String, dynamic>> friends = snapshot.data ?? [];

              if (friends.isEmpty) {
                return const Center(
                  child: Text(
                    "You have no friends yet.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 70), // Για να αφήσουμε χώρο για τα κουμπιά
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final String username = friends[index]['username'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0, // Εδώ προσθέτουμε horizontal padding
                      ),
                      child: AddFriendWidget(
                        username: username,
                        onAddFriendPressed: () {}, // Δεν χρησιμοποιείται εδώ
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Back Button
          Positioned(
            top: 30,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF50B498),
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 24,
                onPressed: () {
                  Navigator.pop(context); // Επιστροφή στην προηγούμενη σελίδα
                },
              ),
            ),
          ),
          // Add Friend Button
          Positioned(
            top: 30,
            right: 16,
            child: AddFriendButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddFriendPopup(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

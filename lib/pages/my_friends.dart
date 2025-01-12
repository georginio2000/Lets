import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/my_profile_page/add_friend_button.dart';
import '../widgets/my_profile_page/add_friend.dart';
import '../widgets/my_friends/user_box_friend.dart';
import '../widgets/settings/back_arrow_button.dart'; // Import your custom BACKButton


class MyFriendsPage extends StatelessWidget {
  const MyFriendsPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchFriends() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    final DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final List<dynamic> friendsIds = userDoc.data()?['friends'] ?? [];

    if (friendsIds.isEmpty) {
      return [];
    }

    final List<Map<String, dynamic>> friends = [];
    for (String friendId in friendsIds) {
      final DocumentSnapshot<Map<String, dynamic>> friendDoc =
      await FirebaseFirestore.instance.collection('users').doc(friendId).get();

      if (friendDoc.exists) {
        friends.add({
          'username': friendDoc.data()?['username'] ?? 'Unknown',
          'uid': friendId,
        });
      }
    }

    return friends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: Stack(
        children: [
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
                padding: const EdgeInsets.only(top: 70),
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final String username = friends[index]['username'];
                    final String uid = friends[index]['uid'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0,
                      ),
                      child: AddFriendWidget(
                        username: username,
                        uid: uid,
                        onAddFriendPressed: () {},
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
            child: BACKButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

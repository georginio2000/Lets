import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'search_user_box.dart';
import 'user_box_not_friend.dart';

class AddFriendPopup extends StatefulWidget {
  const AddFriendPopup({super.key});

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

      // Get the current user's document
      final DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      // Cast data to Map<String, dynamic>
      final Map<String, dynamic>? currentUserData =
      currentUserDoc.data() as Map<String, dynamic>?;

      final List<dynamic> friends = currentUserData?['friends'] ?? [];

      // Fetch users that are not in the friends list and not the current user
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereNotIn: [...friends, currentUserUid])
          .get();

      final List<Map<String, dynamic>> fetchedUsers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['uid'] = doc.id;
        return data;
      }).toList();

      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _searchUser() async {
    final String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      _fetchUsers();
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

      // Get the current user's document
      final DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      // Cast data to Map<String, dynamic>
      final Map<String, dynamic>? currentUserData =
      currentUserDoc.data() as Map<String, dynamic>?;

      final List<dynamic> friends = currentUserData?['friends'] ?? [];

      // Search users that match the username and are not friends
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: searchText)
          .where(FieldPath.documentId, whereNotIn: [...friends, currentUserUid])
          .get();

      final List<Map<String, dynamic>> searchedUsers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['uid'] = doc.id;
        return data;
      }).toList();

      setState(() {
        users = searchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      backgroundColor: const Color(0xFF9CC4C4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add Friends Title
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: Text(
                    'ADD FRIENDS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Use CustomSearchBar
              CustomSearchBar(
                controller: _searchController,
                onSearchPressed: _searchUser,
              ),
              const SizedBox(height: 20),
              // Users List
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: AddFriendWidget(
                        username: user['username'] ?? 'Unknown',
                        onAddFriendPressed: () {
                          _sendFriendRequest(user['uid']);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendFriendRequest(String recipientUid) async {
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('friend_requests')
        .add({'from': currentUserUid, 'to': recipientUid});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Friend request sent!')),
    );
  }
}

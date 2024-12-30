import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/general/activity_feed.dart';
import '../widgets/all_Lets/lets_friends.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late Future<void> _refreshFuture;

  @override
  void initState() {
    super.initState();
    _refreshFuture = _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _refreshFuture = Future.delayed(Duration.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user's UID
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      return const Center(
        child: Text('Error: User not logged in'),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Set the background color to #9CC4C4
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<void>(
          future: _refreshFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 16.0, // Standard top padding
                    left: 16.0, // Standard left padding
                    right: 16.0, // Standard right padding
                    bottom: 4.0, // Very little bottom padding
                  ),
                  child: LetsFriendsWidget(), // Header widget
                ),
                Expanded(
                  child: ActivityFeed(
                    currentUserId: currentUserId, // Pass current user ID
                    showFriendsOnly: true, // Show only friends' activities
                    categoryFilter: null, // No filter by default
                    maxParticipantsFilter: null, // No filter by default
                    locationFilter: null, // No filter by default
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

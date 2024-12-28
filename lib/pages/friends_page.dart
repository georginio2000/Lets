import 'package:flutter/material.dart';
import '../widgets/general/activity_feed.dart';
import '../widgets/all_Lets/lets_friends.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Set the background color to #9CC4C4
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0, // Standard top padding
              left: 16.0, // Standard left padding
              right: 16.0, // Standard right padding
              bottom: 4.0, // Very little bottom padding
            ),
            child: LetsFriendsWidget(), // LetsExploreWidget at the top
          ),
          Expanded(
            child: ActivityFeed(
              // Optionally, you can pass filters here
              categoryFilter: null, // No filter by default
              maxParticipantsFilter: null, // No filter by default
              locationFilter: null, // No filter by default
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'activity_box.dart'; // Ensure this file exists and is implemented correctly

class ActivityFeed extends StatelessWidget {
  final String currentUserId; // Current user's UID
  final bool showFriendsOnly; // Whether to show only friends' activities
  final String? categoryFilter; // Filter by category
  final int? maxParticipantsFilter; // Filter by max participants
  final String? locationFilter; // Filter by location

  const ActivityFeed({
    super.key,
    required this.currentUserId,
    this.showFriendsOnly = false,
    this.categoryFilter,
    this.maxParticipantsFilter,
    this.locationFilter,
  });

  Stream<QuerySnapshot> fetchFilteredActivities() async* {
    Query query = FirebaseFirestore.instance.collection('activities');

    try {
      if (showFriendsOnly) {
        // Fetch current user's friends
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .get();

        if (userDoc.exists && userDoc['friends'] != null) {
          List<String> friends = List<String>.from(userDoc['friends']);
          print('Friends UIDs: $friends'); // Debug log
          if (friends.isNotEmpty) {
            query = query.where('createdBy', whereIn: friends);
          } else {
            print('No friends to filter.');
            yield* const Stream.empty();
            return;
          }
        } else {
          print('User document not found or friends list is null.');
          yield* const Stream.empty();
          return;
        }
      } else {
        // Fetch all activities except the current user's
        query = query.where('createdBy', isNotEqualTo: currentUserId);
      }

      // Apply tag filter (categoryFilter) if provided
      if (categoryFilter != null && categoryFilter!.isNotEmpty) {

        List<String> tags = categoryFilter!.split(', '); // Split the tags into a list
        query = query.where('tags', arrayContainsAny: tags); // Filter by tags
        print('Tags for filtering in ActivityFeed: $tags');
      }

      // Apply max participants filter if provided
      if (maxParticipantsFilter != null) {
        query = query.where(
            'numParticipants', isLessThanOrEqualTo: maxParticipantsFilter);
      }

      // Apply location filter if provided
      if (locationFilter != null && locationFilter != 'All') {
        query = query.where('location', isEqualTo: locationFilter);
      }

      print('Query: ${query.parameters}'); // Debug log query parameters
      yield* query.snapshots(); // Return Firestore real-time stream
    } catch (e) {
      print('Error in fetchFilteredActivities: $e');
      yield* const Stream.empty(); // Return empty stream in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fetchFilteredActivities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading activities'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No activities found'));
        }

        final activities = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activityId = activities[index].id;

            // Use ActivityBox widget to display activity
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ActivityBox(activityId: activityId), // Pass activity ID
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'activity_box.dart';

class ActivityFeed extends StatelessWidget {
  final String? categoryFilter; // Filter by category
  final int? maxParticipantsFilter; // Filter by max participants
  final String? locationFilter; // Filter by location

  const ActivityFeed({
    Key? key,
    this.categoryFilter,
    this.maxParticipantsFilter,
    this.locationFilter,
  }) : super(key: key);

  Stream<QuerySnapshot> fetchFilteredActivities() {
    Query query = FirebaseFirestore.instance.collection('activities');

    // Apply category filter if provided
    if (categoryFilter != null && categoryFilter != 'All') {
      query = query.where('category', isEqualTo: categoryFilter);
    }

    // Apply max participants filter if provided
    if (maxParticipantsFilter != null) {
      query = query.where('numParticipants', isLessThanOrEqualTo: maxParticipantsFilter);
    }

    // Apply location filter if provided
    if (locationFilter != null && locationFilter != 'All') {
      query = query.where('location', isEqualTo: locationFilter);
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Set the background color to #9CC4C4
      body: StreamBuilder<QuerySnapshot>(
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
            padding: const EdgeInsets.all(8), // Add padding for spacing
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activityData =
              activities[index].data() as Map<String, dynamic>;
              final activityId = activities[index].id;

              // Use the existing ActivityBox for styling
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Spacing between boxes
                child: ActivityBox(activityId: activityId),
              );
            },
          );
        },
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase for testing

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const ActivityFeed(),
  ));
}

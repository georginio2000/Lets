import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityBox extends StatelessWidget {
  final String activityId;

  const ActivityBox({super.key, required this.activityId});

  Future<Map<String, dynamic>?> fetchActivityDetails(String activityId) async {
    try {
      DocumentSnapshot activitySnapshot = await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .get();

      if (activitySnapshot.exists) {
        return activitySnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching activity details: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchActivityDetails(activityId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading activity details'));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Activity not found'));
        }

        final activityData = snapshot.data!;
        final title = activityData['title'] ?? 'No title';
        final description = activityData['description'] ?? 'No description';
        final time = activityData['time'] ?? 'No time specified';
        final location = activityData['location'] ?? 'No location specified';
        final distance = "5km"; // Placeholder distance
        final numParticipants = activityData['numParticipants'] ?? 0;
        final maxParticipants = 20;

        return Container(
          height: 192,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7F9), // Light blue background
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.black, width: 1), // Border for the main container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Profile Picture, Title, and Participants Count
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User Profile Picture with Border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 30, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Title and Participants Count with Border
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18, // Slightly smaller font size for title
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis, // Handles long titles
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/PARTICIPANTS_ICON.svg', // Path to your SVG file
                                height: 15, // Set the height
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '$numParticipants/$maxParticipants',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Middle Row: Description Box (Left) and Time/Location (Right)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Box with Border
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 90,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF), // White background
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black, // Border color for description box
                          width: 1,
                        ),
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 5, // Limit to 5 lines
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Time and Location with Borders
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),

                          // Time
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 20),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  time,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Handles long text
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Location
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 3),
                              SvgPicture.asset(
                                'assets/SMALL_MAP_ICON.svg', // Path to your SVG file
                                height: 15, // Set the height
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Handles long text
                                    ),
                                    Text(
                                      '($distance away)',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Main method for testing purposes
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase for testing

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Activity Box Test'),
      ),
      body: Center(
        child: ActivityBox(
          activityId: '3LkBnyuafCis3QczXN40', // Replace with a valid activity ID for testing
        ),
      ),
    ),
  ));
}

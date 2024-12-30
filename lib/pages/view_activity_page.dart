import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widgets/register/register_join_submit_create_button.dart';
import '../widgets/view_activity/view_participants_button.dart';
import '../widgets/view_activity/activity_photos_line.dart';
import '../widgets/my_friends/user_box_friend.dart'; // Replace with the actual path
import 'package:flutter_svg/flutter_svg.dart';


class ViewActivityPage extends StatefulWidget {
  final String activityId;

  const ViewActivityPage({Key? key, required this.activityId}) : super(key: key);

  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  Map<String, dynamic>? activityData;
  Map<String, dynamic>? creatorData; // For storing the creator's details
  bool isLoading = true;
  bool isJoining = false;

  @override
  void initState() {
    super.initState();
    _fetchActivityDetails(widget.activityId);
  }

  Future<void> _fetchActivityDetails(String activityId) async {
    try {
      DocumentSnapshot activitySnapshot = await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .get();

      if (activitySnapshot.exists) {
        activityData = activitySnapshot.data() as Map<String, dynamic>;

        // Fetch the creator's details using the `createdBy` field
        if (activityData?['createdBy'] != null) {
          await _fetchCreatorDetails(activityData!['createdBy']);
        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Activity not found.")),
        );
      }
    } catch (e) {
      print("Error fetching activity details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchCreatorDetails(String creatorId) async {
    try {
      DocumentSnapshot creatorSnapshot = await FirebaseFirestore.instance
          .collection('users') // Assuming the user data is stored in the 'users' collection
          .doc(creatorId)
          .get();

      if (creatorSnapshot.exists) {
        setState(() {
          creatorData = creatorSnapshot.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching creator details: $e");
    }
  }

  Future<void> _joinActivity() async {
    if (isJoining || activityData == null) return;

    setState(() {
      isJoining = true;
    });

    try {
      String userId = "user_id_placeholder"; // Replace with your actual user ID logic

      List<dynamic> joinedParticipants =
      List.from(activityData?['joinedParticipants'] ?? []);

      if (joinedParticipants.contains(userId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You are already a participant.")),
        );
        setState(() {
          isJoining = false;
        });
        return;
      }

      joinedParticipants.add(userId);

      await FirebaseFirestore.instance
          .collection('activities')
          .doc(widget.activityId)
          .update({
        'joinedParticipants': joinedParticipants,
      });

      setState(() {
        activityData?['joinedParticipants'] = joinedParticipants;
        isJoining = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully joined the activity!")),
      );
    } catch (e) {
      print("Error joining activity: $e");
      setState(() {
        isJoining = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to join the activity.")),
      );
    }
  }

  void _viewParticipants() {
    final participants = List<String>.from(activityData?['joinedParticipants'] ?? []);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(participants[index]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : activityData == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Activity not found.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            RegisterJoinSubmitCreateButton(
              labelText: "Back",
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color(0xFFB47150),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding left and right
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Add padding to avoid overlap with buttons
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      activityData?['title'] ?? "No Title",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (creatorData != null)
                    AddFriendWidget(
                      username: creatorData?['username'] ?? "Unknown User",
                      uid: activityData?['createdBy'] ?? "", // Pass the UID of the creator
                      onAddFriendPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Friend request sent to ${creatorData?['username']}!")),
                        );
                      },
                    ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/SMALL_MAP_ICON.svg', // Path to your SVG file
                            height: 24, // Set the height
                          ),                          Text(
                            activityData?['location'] ?? "N/A",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 24),
                          Text(
                            activityData?['dateTime'] ?? "N/A",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Skill Level: ${activityData?['skillLevel'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/PARTICIPANTS_ICON.svg', // Path to your SVG file
                        height: 24, // Set the height
                      ),                      Text(
                        "${(activityData?['joinedParticipants'] ?? []).length} / ${(activityData?['numParticipants'] ?? '-')}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ViewParticipantsButton(activityId: widget.activityId),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _styledContainer(
                    child: Text(
                      "${activityData?['description'] ?? 'No Description'}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: (activityData?['tags'] ?? [])
                        .map<Widget>(
                          (tag) => Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF468585),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tag,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  ActivityPhotosLine(),
                ],
              ),
            ),
            // Fixed Buttons at the Bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color(0xFF9CC4C4), // Background color for the button bar
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegisterJoinSubmitCreateButton(
                      labelText: "Back",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: const Color(0xFFB47150),
                    ),
                    RegisterJoinSubmitCreateButton(
                      labelText: "Join",
                      onPressed: _joinActivity,
                      color: const Color(0xFF50B498),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _styledContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}



void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Activity Page Test',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TestViewActivityPage(),
    );
  }
}

class TestViewActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with a valid activityId from your Firestore database
    const String testActivityId = "QGRSweCBuUKdR7EJ9W4e";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test View Activity Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the ViewActivityPage for testing
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewActivityPage(activityId: testActivityId),
              ),
            );
          },
          child: const Text('Go to View Activity Page'),
        ),
      ),
    );
  }
}

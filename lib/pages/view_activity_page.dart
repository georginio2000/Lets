import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widgets/register/register_join_submit_create_button.dart'; // Replace with the actual path to your custom button file

class ViewActivityPage extends StatefulWidget {
  final String activityId;

  const ViewActivityPage({Key? key, required this.activityId}) : super(key: key);

  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  Map<String, dynamic>? activityData;
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
        setState(() {
          activityData = activitySnapshot.data() as Map<String, dynamic>;
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
            const SizedBox(height: 20),
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
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 24),
                    Text(
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.people, size: 24),
                Text(
                  "${(activityData?['joinedParticipants'] ?? []).length} / ${(activityData?['numParticipants'] ?? '-')}",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 80, // Custom width
              height: 30, // Custom height
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1), // Add border
                borderRadius: BorderRadius.circular(2), // Custom border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _viewParticipants,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF50B498), // Custom background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2), // Match the container radius
                  ),
                  padding: EdgeInsets.zero, // Remove extra padding from the button
                ),
                child: const Text(
                  "VIEW PARTICIPANTS",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
              ),
            ),


            const SizedBox(height: 20),
            _styledContainer(
              child: Text(
                "\n${activityData?['description'] ?? 'No Description'}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: (activityData?['tags'] ?? [])
                  .map<Widget>((tag) => Container(
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
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            _styledContainer(
              child: Text(
                "Skill Level: ${activityData?['skillLevel'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            Row(
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

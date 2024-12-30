import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/my_friends/user_box_friend.dart'; // Replace with the actual import for AddFriendWidget

class ViewParticipantsPopup extends StatefulWidget {
  final String activityId;

  const ViewParticipantsPopup({super.key, required this.activityId});

  @override
  _ViewParticipantsPopupState createState() => _ViewParticipantsPopupState();
}

class _ViewParticipantsPopupState extends State<ViewParticipantsPopup> {
  List<Map<String, dynamic>> participants = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchParticipants();
  }

  Future<void> _fetchParticipants() async {
    setState(() {
      isLoading = true;
    });

    try {
      final DocumentSnapshot<Map<String, dynamic>> activityDoc =
      await FirebaseFirestore.instance.collection('activities').doc(widget.activityId).get();

      final List<dynamic> participantIds = activityDoc.data()?['joinedParticipants'] ?? [];

      if (participantIds.isEmpty) {
        setState(() {
          participants = [];
          isLoading = false;
        });
        return;
      }

      final List<Map<String, dynamic>> fetchedParticipants = [];
      for (String participantId in participantIds) {
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(participantId).get();

        if (userDoc.exists) {
          fetchedParticipants.add({
            'username': userDoc.data()?['username'] ?? 'Unknown',
            'uid': participantId, // Pass the UID here
          });
        }
      }

      setState(() {
        participants = fetchedParticipants;
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      backgroundColor: const Color(0xFF9CC4C4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Participants Title
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: Text(
                    'PARTICIPANTS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Participants List
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    final participant = participants[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: AddFriendWidget(
                        username: participant['username'],
                        uid: participant['uid'], // Pass the UID to the widget
                        onAddFriendPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Friend request sent to ${participant['username']}!"),
                            ),
                          );
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
}

import 'package:flutter/material.dart';
import '../../pages/joinedparticipants_page.dart';


class ViewParticipantsButton extends StatelessWidget {
  final String activityId;

  const ViewParticipantsButton({
    Key? key,
    required this.activityId,
  }) : super(key: key);

  void _showParticipantsDialog(BuildContext context, String activityId) {
    showDialog(
      context: context,
      builder: (context) => ViewParticipantsPopup(activityId: activityId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 30,
      child: ElevatedButton(
        onPressed: () => _showParticipantsDialog(context, activityId),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE5FFFF), // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2), // Rounded corners
          ),
          side: const BorderSide(
            color: Colors.black, // Border color
            width: 1, // Border width
          ),
          elevation: 4, // Adds a shadow to the button
        ),
        child: const Text(
          "VIEW THE PARTICIPANTS",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
          ),
        ),
      ),
    );
  }
}

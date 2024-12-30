import 'package:flutter/material.dart';
import '../../pages/view_activity_page.dart'; // Import the ViewActivityPage

class MapActivityButton extends StatelessWidget {
  final String title;
  final String time;
  final String activityId;

  const MapActivityButton({
    Key? key,
    required this.title,
    required this.time,
    required this.activityId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Button tapped!');
        // Navigation logic here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewActivityPage(activityId: activityId),
          ),
        );
      },
      child: Container(
        width: 120, // Fixed width
        height: 55, // Fixed height
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF50B498),
          border: Border.all(
            color: Colors.black, // Black border
            width: 1, // Border width
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(2), // Different radius for bottom-left
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis, // Handle long text
              maxLines: 1, // Limit title to one line
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.black,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long text
                    maxLines: 1, // Limit time to one line
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

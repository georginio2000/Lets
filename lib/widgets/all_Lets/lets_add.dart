import 'package:flutter/material.dart';

class LetsAddWidget extends StatelessWidget {
  const LetsAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LET'S text
          Text(
            "LET'S",
            style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.grey,
                  offset: Offset(1, 4),
                ),
              ],
            ),
          ),
          SizedBox(width: 12), // Space between LET'S and the right text
          // JOIN OUR FRIENDS text
          Padding(
            padding: EdgeInsets.only(top: 14), // Adjust vertical alignment
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CREATE AN",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.grey,
                        offset: Offset(1, 4),
                      ),
                    ],
                  ),
                ),
                Text(
                  "ACTIVITY",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.grey,
                        offset: Offset(1, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

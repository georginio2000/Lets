import 'package:flutter/material.dart';

class LetsExploreWidget extends StatelessWidget {
  const LetsExploreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "EXPLORE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }
}

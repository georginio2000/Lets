import 'package:flutter/material.dart';

class LetsStartWidget extends StatelessWidget {
  const LetsStartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -10,
            left: 110,
            child: Text(
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
          ),
          Positioned(
            top: 50,
            left: 110,
            child: Text(
              "START",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Colors.grey,
                    offset: Offset(1, 5),
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

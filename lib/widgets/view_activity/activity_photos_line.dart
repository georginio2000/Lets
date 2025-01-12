import 'package:flutter/material.dart';

class ActivityPhotosLine extends StatelessWidget {
  const ActivityPhotosLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "PHOTOS ",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
        const Center(
          child: Text(
            "No Photos ",
            style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 100),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),

            ],
          ),
        ),
        const SizedBox(height: 15),

      ],
    );
  }
}

import 'package:flutter/material.dart';

class AgeBox extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AgeBox({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 90,
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE5E1DA),
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15, left: 5), // Ρυθμίζει το input
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 15,
          child: Text(
            "AGE",
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black38,
            ),
          ),
        ),
      ],
    );
  }
}

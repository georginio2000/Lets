import 'package:flutter/material.dart';

class BoxForRegisterPage extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const BoxForRegisterPage({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 260,
          height: 40,
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
            obscureText: obscureText,
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
            hintText,
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

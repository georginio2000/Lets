import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const DontHaveAccount({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "DON'T HAVE AN ACCOUNT?",
          style: TextStyle(
            fontSize: 5,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 7),
        Container(
          width: 70,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            color: const Color(0xFFE5E1DA),
          ),
          child: TextButton(
            onPressed: onButtonPressed,
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 5,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

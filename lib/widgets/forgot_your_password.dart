import 'package:flutter/material.dart';

class ForgotYourPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotYourPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 17,
      decoration: BoxDecoration(
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE5E1DA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text(
          "FORGOT YOUR PASSWORD?",
          style: TextStyle(
            fontSize: 6,
            //fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
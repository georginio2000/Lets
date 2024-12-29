import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String labelText; // Το label πάνω από το TextField
  final String initialValue; // Αρχική τιμή (actual value) που θα εμφανιστεί μέσα στο TextField
  final TextEditingController controller; // Controller για διαχείριση τιμών

  const InfoBox({
    super.key,
    required this.labelText,
    required this.initialValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Ορίστε την αρχική τιμή του controller αν είναι άδειος
    controller.text = controller.text.isEmpty ? initialValue : controller.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            labelText, // Εμφάνιση του label πάνω από το TextField
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: 280,
          height: 50,
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
            controller: controller, // Χρησιμοποιείται για το TextField
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

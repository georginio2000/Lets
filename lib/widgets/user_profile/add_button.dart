import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF50B498), // Χρώμα φόντου του κουμπιού
        borderRadius: BorderRadius.circular(0), // Ελαφρώς στρογγυλεμένες γωνίες
        border: Border.all(color: Colors.black, width: 1.0), // Μαύρο περίγραμμα
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Ελαφριά σκιά
            blurRadius: 4, // Απαλότητα της σκιάς
            offset: const Offset(2, 4), // Θέση της σκιάς
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, // Διάφανο υλικό για κλικ
        child: InkWell(
          borderRadius: BorderRadius.circular(0),
          onTap: onPressed, // Ενέργεια όταν πατηθεί
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Κυκλικό εσωτερικό κουμπί
                border: Border.all(color: Colors.black, width: 1.0), // Μαύρο περίγραμμα
              ),
              child: const Center(
                child: Icon(
                  Icons.add, // Σύμβολο +
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

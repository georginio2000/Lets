import 'package:flutter/material.dart';

class UsernamePasswordBox extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const UsernamePasswordBox({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  _UsernamePasswordBoxState createState() => _UsernamePasswordBoxState();
}

class _UsernamePasswordBoxState extends State<UsernamePasswordBox> {
  bool isTextEmpty = true; // Αρχικά το πεδίο θεωρείται κενό

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkText); // Listener για αλλαγές στο πεδίο
  }

  void _checkText() {
    setState(() {
      isTextEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkText); // Καθαρισμός του listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: 220,
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
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: isTextEmpty
                  ? null // Δεν εμφανίζεται το εικονίδιο αν το πεδίο είναι κενό
                  : widget.suffixIcon,
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

import 'package:flutter/material.dart';

class BoxForRegisterPage extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const BoxForRegisterPage({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  _BoxForRegisterPageState createState() => _BoxForRegisterPageState();
}

class _BoxForRegisterPageState extends State<BoxForRegisterPage> {
  bool _showHintText = true;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {
        _showHintText = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

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
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(5),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        if (_showHintText)
          Positioned(
            top: 5,
            left: 15,
            child: Text(
              widget.hintText,
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

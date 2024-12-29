import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Empty Page',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Επιστροφή στην προηγούμενη σελίδα
          },
        ),
      ),
      body: const Center(
        child: Text(
          'This page is empty.',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}

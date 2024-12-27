import 'package:flutter/material.dart';
import '../widgets/settings/settings_box.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Background color
      body: Stack(
        children: [
          // Back button
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF50B498), // Button background color
                border: Border.all(color: Colors.black, width: 1), // Border
                borderRadius: BorderRadius.circular(2),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black, // Icon color
                iconSize: 24, // Icon size
                onPressed: () {
                  Navigator.pop(context); // Back to the previous page
                },
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    SettingsBox(
                      labelText: "VIEW YOUR INFO",
                      onPressed: () {
                        print("VIEW YOUR INFO");
                      },
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "CHANGE YOUR PASSWORD",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "CHANGE YOUR EMAIL",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "EMAIL NOTIFICATIONS",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "PUSH NOTIFICATIONS",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "LANGUAGE",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "FAQ",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "FEEDBACK AND SUPPORT",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "ABOUT LETS",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SettingsBox(
                      labelText: "LOGOUT",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

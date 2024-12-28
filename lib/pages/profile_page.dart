import 'package:flutter/material.dart';
import '../widgets/my_profile_page/settings_button.dart';
import '../pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: Center(
        child: SettingsIcon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
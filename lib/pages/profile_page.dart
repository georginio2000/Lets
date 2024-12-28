import 'package:flutter/material.dart';
import '../widgets/my_profile_page/settings_button.dart';
import '../pages/settings_page.dart';
import '../widgets/my_profile_page/add_friend_button.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: 20,
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
              Positioned(
                top: 30,
                left: 20,
                child: AddFriendButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Add Friend Button Pressed!")),
                    );
                  },
                ),
              ),
              // Προσθέστε οποιοδήποτε άλλο περιεχόμενο εδώ
            ],
          ),
        ),
      ),
    );
  }
}

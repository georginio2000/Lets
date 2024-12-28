import 'package:flutter/material.dart';
import '../widgets/my_profile_page/settings_button.dart';
import '../pages/settings_page.dart';
import '../widgets/my_profile_page/add_friend_button.dart';
import '../widgets/my_profile_page/profile_pic_username.dart';
import '../widgets/my_profile_page/numbers_of_friends_activities.dart';

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
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 120,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: const ProfileWidget(),
              ),
              Positioned(
                  top: 320,
                  left: MediaQuery.of(context).size.width / 2 - 130 ,
                  child: const FriendsActivitiesWidget(),
              )
              // Προσθέστε οποιοδήποτε άλλο περιεχόμενο εδώ
            ],
          ),
        ),
      ),
    );
  }
}

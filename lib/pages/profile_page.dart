import 'package:flutter/material.dart';
import '../widgets/my_profile_page/settings_button.dart';
import '../pages/settings_page.dart';
import '../widgets/my_profile_page/add_friend_button.dart';
import '../widgets/my_profile_page/profile_pic_username.dart';
import '../widgets/my_profile_page/numbers_of_friends_activities.dart';
import '../widgets/my_profile_page/bio_box.dart';
import '../widgets/my_profile_page/past_activities_line.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();

  ProfilePage({super.key});

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
              // Settings Button
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
              // Add Friend Button
              Positioned(
                top: 30,
                left: 20,
                child: AddFriendButton(
                  onPressed: () {},
                ),
              ),
              // Profile Picture and Username
              Positioned(
                top: 120,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: const ProfileWidget(),
              ),
              // Friends and Activities Count
              Positioned(
                top: 320,
                left: MediaQuery.of(context).size.width / 2 - 130,
                child: const FriendsActivitiesWidget(),
              ),
              // Bio Box
              Positioned(
                top: 400,
                left: MediaQuery.of(context).size.width / 2 - 150,
                child: const SizedBox(
                  width: 300,
                  child: BioBox(),
                ),
              ),
              // Past Activities Section
              const Positioned(
                top: 480,
                left: 0,
                right: 0,
                child: PastActivities(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/user_profile/profile_pic_username.dart';
import '../widgets/user_profile/bio_box.dart';
import '../widgets/my_profile_page/past_activities_line.dart';
import '../widgets/my_friends/friends_activities_widget_with_no_+_button.dart';
class UserPage extends StatelessWidget {
  final String uid;

  const UserPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFF9CC4C4),
              ),
              Positioned(
                top: 120,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: ProfileWidgetUser(uid: uid),
              ),
              Positioned(
                top: 320,
                left: MediaQuery.of(context).size.width / 2 - 130,
                child: FriendsActivitiesWidgetNoButton(uid: uid),
              ),
              Positioned(
                top: 400,
                left: MediaQuery.of(context).size.width / 2 - 150,
                child: const SizedBox(
                  width: 300,
                  child: BioBoxUser(
                    uid: 'USER_ID_HERE',
                  ),
                ),
              ),
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

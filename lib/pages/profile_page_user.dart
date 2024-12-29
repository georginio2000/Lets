import 'package:flutter/material.dart';
import '../widgets/user_profile/profile_pic_username.dart'; // Το widget για το profile
import '../widgets/user_profile/numbers_of_friends_activities.dart'; // Το νέο widget για activities και friends
import '../widgets/user_profile/bio_box.dart';
import '../widgets/my_profile_page/past_activities_line.dart';
class UserPage extends StatelessWidget {
  final String uid; // Αναγνωριστικό του χρήστη

  const UserPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // Χρώμα φόντου
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Ύψος για το Stack
          child: Stack(
            children: [
              // Background
              Container(
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFF9CC4C4), // Χρώμα φόντου
              ),
              // Positioned Profile
              Positioned(
                top: 120, // Ρυθμίζουμε τη θέση από πάνω
                left: MediaQuery.of(context).size.width / 2 - 60, // Κεντράρουμε οριζόντια
                child: ProfileWidgetUser(uid: uid), // Καλούμε το widget για το προφίλ
              ),
              // Positioned Activities and Friends
              Positioned(
                top: 320, // Ρυθμίζουμε τη θέση από πάνω
                left: MediaQuery.of(context).size.width / 2 - 140, // Κεντράρουμε οριζόντια
                child: FriendsActivitiesWidget(uid: uid), // Καλούμε το widget για activities και friends
              ),
              Positioned(
                top: 400,
                left: MediaQuery.of(context).size.width / 2 - 150,
                child: const SizedBox(
                  width: 300,
                  child: BioBoxUser(
                    uid: 'USER_ID_HERE', // Αντικατάστησε με το UID του χρήστη
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

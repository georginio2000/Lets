import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/settings/settings_box.dart';
import '../widgets/settings/language_dialog.dart';
import '../widgets/settings/user_info_dialog.dart';
import '../widgets/settings/about_lets_dialog.dart';
import 'login_page.dart';
import '../widgets/settings/faq.dart';
import '../widgets/settings/feedback_support_dialog.dart';
import '../widgets/settings/change_password_dialog.dart';
import '../widgets/settings/change_username_dialog.dart';
import '../widgets/settings/back_arrow_button.dart'; // Import your custom BACKButton widget

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: BACKButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SettingsBox(
                    labelText: "VIEW YOUR INFO",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ViewYourInfoDialog(),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "CHANGE YOUR PASSWORD",
                    onPressed: () {
                      ChangePasswordDialog.show(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "CHANGE YOUR USERNAME",
                    onPressed: () {
                      ChangeUsernameDialog.show(context);
                    },
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
                    onPressed: () {
                      LanguageDialog.show(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "FAQ",
                    onPressed: () {
                      FAQDialog.show(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "FEEDBACK AND SUPPORT",
                    onPressed: () {
                      FeedbackSupportDialog.show(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "ABOUT LETS",
                    onPressed: () {
                      AboutLetsDialog.show(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  SettingsBox(
                    labelText: "LOGOUT",
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logout failed: $e')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

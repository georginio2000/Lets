import 'package:flutter/material.dart';
import '../widgets/back_button.dart'; // Custom Back Button
import '../widgets/register_join_submit_create_button.dart'; // Custom Register Button

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: const Color(0xFF50B498), // Green color for the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Back Button
            RedBackButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),

            const SizedBox(height: 20), // Spacing between buttons

            // Register Button
            RegisterJoinSubmitCreateButton(
              labelText: "REGISTER",
              onPressed: () {
                // TODO: Handle the registration logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}

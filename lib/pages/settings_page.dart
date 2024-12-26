import 'package:flutter/material.dart';
import '../widgets/settings_box.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // background xrwma
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SettingsBox(
                  labelText: "VIEW YOUR INFO",
                  onPressed: (){
                    print("VIEW YOUR INFO");
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "CHANGE YOUR PASSWORD",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "CHANGE YOUR EMAIL",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "EMAIL NOTIFICATIONS",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "PUSH NOTIFICATIONS",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "LANGUAGE",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "FAQ",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "FEEDBACK AND SUPPORT",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "ABOUT LETS",
                  onPressed: (){
                  },
                ),
                const SizedBox(height: 30),
                SettingsBox(
                  labelText: "LOGOUT",
                  onPressed: (){
                  },
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

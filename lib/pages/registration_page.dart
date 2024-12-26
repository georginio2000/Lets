import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';
import '../widgets/box_for_register_page.dart';
import '../widgets/register_join_submit_create_button.dart';
import '../widgets/register_age.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController phonenumberController = TextEditingController();
    final TextEditingController repeatpasswordController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController genderController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4), // background xrwma
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -10,
                        left: 110,
                        child: Text(
                          "LET'S",
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: Colors.grey,
                                offset: Offset(1, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 110,
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: Colors.grey,
                                offset: Offset(1, 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                BoxForRegisterPage(
                  hintText: "FIRST NAME",
                  controller: firstnameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "LAST NAME",
                  controller: lastnameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "EMAIL",
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "PHONE NUMBER",
                  controller: phonenumberController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "USERNAME",
                  controller: usernameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "PASSWORD",
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                BoxForRegisterPage(
                  hintText: "REPEAT PASSWORD",
                  controller: repeatpasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 15),

                AgeBox(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 45),

                Row(
                  children: [
                    SizedBox(width: 30),
                    RegisterJoinSubmitCreateButton(
                      labelText: "BACK",
                      color: Color(0xFFB47150),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        print("BACK O BRO, WRAIOS");
                      },
                    ),
                    SizedBox(width: 30), // Χώρος 20 μονάδων από την αριστερή πλευρά
                    RegisterJoinSubmitCreateButton(
                      labelText: "REGISTER",
                      color: Color(0xFF50B498),
                      onPressed: () {
                        print("REGISTER O BRO, WRAIOS");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

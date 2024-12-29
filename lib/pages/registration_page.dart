import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';
import '../widgets/register/box_for_register_page.dart';
import '../widgets/register/register_join_submit_create_button.dart';
import '../widgets/register/register_age.dart';
import '../widgets/register/gender_dropdown.dart';
import '../widgets/all_Lets/lets_register.dart';

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
      backgroundColor: const Color(0xFF9CC4C4),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LetsRegisterWidget(),

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    AgeBox(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(width: 20),
                    const GenderDropdownMenu(),
                  ]
                ),
                const SizedBox(height: 45),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegisterJoinSubmitCreateButton(
                      labelText: "BACK",
                      color: const Color(0xFFB47150),
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
                    const SizedBox(width: 30),
                    RegisterJoinSubmitCreateButton(
                      labelText: "REGISTER",
                      color: const Color(0xFF50B498),
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

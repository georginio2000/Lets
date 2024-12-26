import 'package:flutter/material.dart';
import '../widgets/login_button.dart';
import '../widgets/forgot_your_password.dart';
import '../pages/registration_page.dart';
import '../widgets/sign_in_with.dart';
import '../widgets/dont_have_account.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                  height: 100, // Ύψος του Stack
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
                          "START",
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

                // Username Box  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: Text(
                        "USERNAME",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E1DA),
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                // Password Box  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E1DA),
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Login Button !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                LoginButton(
                  onPressed: () { // edw to onPressed einai h synarthsh parametros poy pernaw sto login button.
                    print("Username re bro");
                  },
                ),

                const SizedBox(height: 6),

                // FORFOT YOUR PASSWORD BUTTON !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                ForgotYourPasswordButton(
                  onPressed: (){
                    print("Forgot your password re bro");
                  },
                ),

                const SizedBox(height: 6),

                // DONT HAVE AN ACCOUNT? SIGN UP TEXT-BUTTON !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                DontHaveAccount(
                  onButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // MICROSOFT
                SignInWith(
                  text: "SIGN IN WITH MICROSOFT",
                  onPressed: () {
                    print("SIGN IN WITH MICROSOFT RE BRO");
                  },
                ),

                const SizedBox(height: 10),

                // SIGN UP WITH FACEBOOK !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                SignInWith(
                  text: "SIGN IN WITH FACEBOOK",
                  onPressed: () {
                    print("SIGN IN WITH FACEBOOK RE BRO");
                  },
                ),

                const SizedBox(height: 10),

                //SIGN UP WITH GOOGLE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                SignInWith(
                  text: "SIGN IN WITH GOOGLE",
                  onPressed: () {
                    print("SIGN IN WITH GOOGLE RE BRO");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

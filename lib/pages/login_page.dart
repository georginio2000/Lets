import 'package:flutter/material.dart';
import 'package:project/pages/settings_page.dart';
import '../widgets/login_button.dart';
import '../widgets/forgot_your_password.dart';
import '../pages/registration_page.dart';
import '../widgets/sign_in_with.dart';
import '../widgets/dont_have_account.dart';
import '../widgets/login_username_password_box.dart';
import '../widgets/lets_start.dart';
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
                const LetsStartWidget(),

                const SizedBox(height: 30),

                // Username Box  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                UsernamePasswordBox(
                  labelText: "USERNAME",
                  controller: usernameController,
                ),

                const SizedBox(height: 5),

                // Password Box!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                UsernamePasswordBox(
                  labelText: "PASSWORD",
                  controller: passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                // Login Button !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                LoginButton(
                  onPressed: () { // edw to onPressed einai h synarthsh parametros poy pernaw sto login button.
                    print("ekanes login re bro");
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
                    // EXW VALEI EDW KAI KALA NA PATAS TO BUTTON GIA NA PAS SETTINGS GIA NA TO TSEKAROYME
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
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

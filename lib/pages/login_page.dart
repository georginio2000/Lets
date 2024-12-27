import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/settings_page.dart';
import 'package:project/pages/home_page.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/forgot_your_password.dart';
import '../pages/registration_page.dart';
import '../widgets/login/sign_in_with.dart';
import '../widgets/login/dont_have_account.dart';
import '../widgets/login/login_username_password_box.dart';
import '../widgets/all_Lets/lets_start.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
      // Μετάβαση σε άλλη σελίδα
      //Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed, try again.')),
      );
    }
  }

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
                const LetsStartWidget(),

                const SizedBox(height: 30),

                // Username Box
                UsernamePasswordBox(
                  labelText: "USERNAME",
                  controller: usernameController,
                ),

                const SizedBox(height: 5),

                // Password Box
                UsernamePasswordBox(
                  labelText: "PASSWORD",
                  controller: passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                // Login Button
                LoginButton(
                  onPressed: () {
                    signIn(); // Κλήση της συνάρτησης signIn
                  },
                ),

                const SizedBox(height: 6),

                // Forgot Your Password Button
                ForgotYourPasswordButton(
                  onPressed: () {
                    print("Forgot your password re bro");
                  },
                ),

                const SizedBox(height: 6),

                // Don't Have an Account? Sign Up
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

                // Microsoft
                SignInWith(
                  text: "SIGN IN WITH MICROSOFT",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Sign Up With Facebook
                SignInWith(
                  text: "SIGN IN WITH FACEBOOK",
                  onPressed: () {
                    print("SIGN IN WITH FACEBOOK RE BRO");
                  },
                ),

                const SizedBox(height: 10),

                // Sign Up With Google
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

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/settings_page.dart';
import 'package:project/pages/main_screen.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/forgot_your_password.dart';
import '../pages/registration_page.dart';
import '../widgets/login/sign_in_with.dart';
import '../widgets/login/dont_have_account.dart';
import '../widgets/login/login_username_password_box.dart';
import '../widgets/all_Lets/lets_start.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
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
                  controller: emailController,
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                // Password Box with Toggle
                UsernamePasswordBox(
                  labelText: "PASSWORD",
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Login Button
                LoginButton(
                  onPressed: () {
                    signIn();
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

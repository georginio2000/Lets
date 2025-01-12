import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/pages/main_screen.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/forgot_your_password.dart';
import '../pages/registration_page.dart';
import '../widgets/login/sign_in_with.dart';
import '../widgets/login/dont_have_account.dart';
import '../widgets/login/login_username_password_box.dart';
import '../widgets/all_Lets/lets_start.dart';
import 'package:project/pages/empty_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

  Future<void> signInWithEmailPassword() async {
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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Show dialog to ask user if they want to use the same account or a different account
      final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF9CC4C4), // Same color as the login page
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded corners
            ),
            title: const Text(
              'Sign-In Options',
              style: TextStyle(color: Colors.black), // Text color
            ),
            content: const Text(
              'Do you want to sign in with the same account or a different account?',
              style: TextStyle(color: Colors.black), // Text color
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'same');
                },
                child: const Text(
                  'Same',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'different');
                },
                child: const Text(
                  'Different Account',
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ],
          );
        },
      );

      // If the user wants to use a different account, sign out
      if (result == 'different') {
        await googleSignIn.signOut();
      }

      // Continue with Google Sign-In
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome, ${userCredential.user?.displayName}!'),
          ),
        );

        // Check if the user is signing in for the first time
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (!userDoc.exists) {
          // User is signing in for the first time, navigate to the registration page with email
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationPageWith(
                email: userCredential.user!.email!, // Pass the email to the registration page
              ),
            ),
          );
        } else {
          // Navigate to the main screen if user already exists
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Sign-In canceled.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
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
                  labelText: "EMAIL",
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
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                  onPressed: signInWithEmailPassword,
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

                // Sign In With Google
                SignInWith(
                  text: "SIGN IN WITH GOOGLE",
                  onPressed: signInWithGoogle, // Call Google Sign-In logic
                ),

                const SizedBox(height: 10),

                // Sign In With Microsoft (Example Placeholder)
                SignInWith(
                  text: "SIGN IN WITH MICROSOFT",
                  onPressed: () {
                    print("SIGN IN WITH MICROSOFT RE BRO");
                  },
                ),

                const SizedBox(height: 10),

                // Sign Up With Facebook (Example Placeholder)
                SignInWith(
                  text: "SIGN IN WITH FACEBOOK",
                  onPressed: () {
                    print("SIGN IN WITH FACEBOOK RE BRO");
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

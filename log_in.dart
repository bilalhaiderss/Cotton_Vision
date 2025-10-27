import 'package:cotton_app/sign_up.dart';
import 'package:cotton_app/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoading = false;
  bool obscurePassword = true;

  void signInWithEmailAndPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        showErrorSnackBar(e.message);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showErrorSnackBar('An unexpected error occurred. Please try again.');
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          isLoading = false;
        });
        showErrorSnackBar('Google Sign-In aborted.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorSnackBar(e.message);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorSnackBar('An unexpected error occurred. Please try again.');
    }
  }

  void showErrorSnackBar(String? message) {
    final snackBar = SnackBar(
      content: Text(
        message ?? 'Unknown error occurred',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void goToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/login.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffC19A6B),
                        ),
                      ),
                      const Text(
                        'Please Login',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xffC19A6B),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: Color(0xffC19A6B),
                            ),
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Color(0xffC19A6B),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ForgotPasswordPage.id,
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xffC19A6B),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xffC19A6B),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      isLoading
                          ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          )
                          : SizedBox(
                            width: 350,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  signInWithEmailAndPassword(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffC19A6B),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      const SizedBox(height: 90),
                      TextButton(
                        onPressed: () => goToSignUpPage(context),
                        child: const Text(
                          'Not a registered user? Register Now',
                          style: TextStyle(
                            color: Color(0xffC19A6B),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

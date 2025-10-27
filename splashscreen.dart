import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'log_in.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const id = 'splashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), checkUserAuthentication);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkUserAuthentication() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      navigateToHome();
    } else {
      navigateToLogin();
    }
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (_) => false);
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/cotton.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          ' Cotton Prediction',
                          textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Image.asset(
                      'lib/assets/images/cc.png',
                      height: 140,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Your trusted partner in agriculture',
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //   Positioned(
          //     top: 40,
          //     right: 20,
          //     child: FadeTransition(
          //       opacity: _fadeAnimation,
          //       child: Image.asset(
          //         'lib/assets/images/c.png',
          //         height: 50,
          //         width: 50,
          //       ),
          //     ),
          //   ),

          //   Positioned(
          //     bottom: 40,
          //     left: 20,
          //     child: FadeTransition(
          //       opacity: _fadeAnimation,
          //       child: Image.asset(
          //         'lib/assets/images/c2.png',
          //         height: 100,
          //         width: 100,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

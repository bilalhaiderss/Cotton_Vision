import 'package:cotton_app/bottombar.dart';
import 'package:cotton_app/home.dart';
import 'package:cotton_app/splashscreen.dart';
import 'package:cotton_app/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'firebase_options.dart';
import 'forget_password.dart';
import 'log_in.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: "AIzaSyBQ_XH8X8mlco8QjE-Xyymwi58AcHBb3Gs");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cotton  Predictor',
      theme: ThemeData(
        // primaryColor: const Color.fromRGBO(33, 150, 243, 1),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffC19A6B)),
        textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.black)),
      ),
      // home: const MyHomePage(),
      // home:  const ForgotPasswordPage(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        HomePage.id: (context) => HomePage(),
        LoginPage.id: (context) => const LoginPage(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        bottombar.id: (context) => bottombar(),
      },
    );
  }
}

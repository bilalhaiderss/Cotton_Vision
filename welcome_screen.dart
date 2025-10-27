import 'package:cotton_app/bottombar.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const id = 'welcomescreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _buttonController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _buttonController.forward();
      }
    });

    _buttonController.forward();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.tealAccent.shade100,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: AnimatedTextKit(
        //     animatedTexts: [
        //       FadeAnimatedText(
        //         'Cotton Predictor',
        //         textStyle: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 24.0,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //     repeatForever: true,
        //   ),
        backgroundColor: Colors.white,
        // ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       const DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.teal,
        //         ),
        //         child: Text(
        //           'Menu',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.logout),
        //         title: const Text('Logout'),
        //         onTap: () => _logout(context),
        //       ),
        //     ],
        //   ),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/pp.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cotton Predictor',
                  style: TextStyle(
                    color: Color(0xffC19A6B),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  // 'Your trusted partner in agriculture',
                  'Where Technology Meets Tradition',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC19A6B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                bottombar(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: Text(
                      'Get started',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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

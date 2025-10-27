import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static const id = 'forgot_password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );
        _animationController.forward();
        Fluttertoast.showToast(
          msg: "Password reset email sent",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _showBottomSheet();
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.email_outlined,
                color: Color(0xffC19A6B),
                size: 50,
              ),
              const SizedBox(height: 10),
              SizeTransition(
                sizeFactor: _animation,
                axisAlignment: -1.0,
                child: const Text(
                  'A password reset link will be sent to your email.',
                  style: TextStyle(
                    color: Color(0xffC19A6B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffC19A6B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffC19A6B),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,

                        // MediaQuery.of(context).size.height * 0.26,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/assets/images/forgot.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Color(0xffC19A6B)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xffC19A6B)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            BorderSide(color: Colors.teal.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xffC19A6B)),
                      ),
                      fillColor: Color(0xffC19A6B).withOpacity(0.1),
                      filled: true,
                    ),
                    style: const TextStyle(color: Colors.black),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            onPressed: _sendPasswordResetEmail,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: Color(0xffC19A6B),
                            ),
                            child: const Text(
                              'Send',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

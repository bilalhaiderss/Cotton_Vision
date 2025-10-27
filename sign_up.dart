// import 'package:cotton_app/log_in.dart';
// import 'package:cotton_app/welcome_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({Key? key}) : super(key: key);
//   static const id = 'signup';

//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;
//   final _nameController = TextEditingController();
//   bool _isLoading = false;
//   bool obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _registerWithEmailAndPassword() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true; // Show a loading indicator or disable the button
//       });

//       try {
//         // Optional: Sign out if a user is already signed in
//         if (_auth.currentUser != null) {
//           await _auth.signOut();
//         }

//         // Attempt to create a new user
//         await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );

//         // Navigate to the welcome screen on successful signup
//         Navigator.pushReplacementNamed(context, WelcomeScreen.id);
//       } catch (e) {
//         String errorMessage = 'An error occurred. Please try again.';

//         // Check for Firebase specific errors
//         if (e is FirebaseAuthException) {
//           switch (e.code) {
//             case 'email-already-in-use':
//               errorMessage = 'This email is already registered.';
//               break;
//             case 'invalid-email':
//               errorMessage = 'The email address is not valid.';
//               break;
//             case 'operation-not-allowed':
//               errorMessage = 'Email/password accounts are not enabled.';
//               break;
//             case 'weak-password':
//               errorMessage = 'The password is too weak.';
//               break;
//             default:
//               errorMessage = e.message ?? errorMessage;
//           }
//         }

//         // Show the error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage),
//             duration: const Duration(seconds: 3),
//           ),
//         );

//         // Debug print
//         print('Signup error: $e');
//       } finally {
//         setState(() {
//           _isLoading = false; // Hide the loading indicator or enable the button
//         });
//       }
//     }
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters long';
//     }
//     if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
//       return 'Password must include at least one special character';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!FocusScope.of(context).hasPrimaryFocus) {
//           FocusScope.of(context).unfocus();
//         }
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.26,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('lib/assets/images/login.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 7),
//                       const Text(
//                         'Welcome!',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xffC19A6B),
//                         ),
//                       ),
//                       const Text(
//                         'Please Signup',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xffC19A6B),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: 350,
//                         child: TextFormField(
//                           controller: _nameController,
//                           keyboardType: TextInputType.name,
//                           textInputAction: TextInputAction.next,
//                           decoration: InputDecoration(
//                             labelText: 'Name',
//                             labelStyle: const TextStyle(
//                               color: Color(0xffC19A6B),
//                             ),
//                             prefixIcon: const Icon(Icons.person),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: (String? value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your Name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: 350,
//                         child: TextFormField(
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             labelStyle: const TextStyle(
//                               color: Color(0xffC19A6B),
//                             ),
//                             prefixIcon: const Icon(Icons.email),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: (String? value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: 350,
//                         child: TextFormField(
//                           controller: _passwordController,
//                           obscureText: obscurePassword,
//                           textInputAction: TextInputAction.done,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             labelStyle: const TextStyle(
//                               color: Color(0xffC19A6B),
//                             ),
//                             prefixIcon: const Icon(Icons.lock),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 obscurePassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   obscurePassword = !obscurePassword;
//                                 });
//                               },
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: _validatePassword,
//                           //  (String? value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter your password';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                       ),
//                       const SizedBox(height: 35),
//                       _isLoading
//                           ? const Center(
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.black,
//                               ),
//                             ),
//                           )
//                           : SizedBox(
//                             width: 350,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // if (_formKey.currentState!.validate()) {
//                                 //   Navigator.pushNamed(context, SignupPage.id);
//                                 // }
//                                 _isLoading
//                                     ? null
//                                     : _registerWithEmailAndPassword();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xffC19A6B),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 15,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       const SizedBox(height: 100),
//                       TextButton(
//                         onPressed:
//                             () => Navigator.pushNamed(context, LoginPage.id),
//                         child: const Text(
//                           'Already have an account? Login Now',
//                           style: TextStyle(
//                             color: Color(0xffC19A6B),
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'log_in.dart'; // Ensure this file exports LoginPage
import 'welcome_screen.dart'; // Ensure this file exports WelcomeScreen

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _nameController = TextEditingController();
  bool _isLoading = false;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _registerWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Sign out any existing user
        if (_auth.currentUser != null) {
          await _auth.signOut();
        }

        // Create a new user
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

        // Optionally update user display name
        await userCredential.user?.updateDisplayName(
          _nameController.text.trim(),
        );

        // Navigate to WelcomeScreen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
      } catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'email-already-in-use':
              errorMessage = 'This email is already registered.';
              break;
            case 'invalid-email':
              errorMessage = 'The email address is not valid.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Email/password accounts are not enabled.';
              break;
            case 'weak-password':
              errorMessage = 'The password is too weak.';
              break;
            default:
              errorMessage = e.message ?? errorMessage;
          }
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: const Duration(seconds: 3),
            ),
          );
        }

        print('Signup error: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
      return 'Password must include at least one special character';
    }
    return null;
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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.26,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/login.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
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
                        'Please Signup',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xffC19A6B),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: const TextStyle(
                              color: Color(0xffC19A6B),
                            ),
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                              color: Color(0xffC19A6B),
                            ),
                            prefixIcon: const Icon(Icons.email),
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
                          controller: _passwordController,
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Color(0xffC19A6B),
                            ),
                            prefixIcon: const Icon(Icons.lock),
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
                          validator: _validatePassword,
                        ),
                      ),
                      const SizedBox(height: 35),
                      _isLoading
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
                              onPressed:
                                  _isLoading
                                      ? null
                                      : _registerWithEmailAndPassword,
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
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Already have an account? Login Now',
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

// import 'package:cotton_app/log_in.dart'; // assuming your login page
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     User? user = _auth.currentUser;

//     return Scaffold(
//       appBar: AppBar(title: Text('Profile'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display the user's name and email
//             if (user != null)
//               Column(
//                 children: [
//                   Text(
//                     'Welcome, ${user.displayName ?? "User"}',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${user.email}',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 30),

//             // Logout Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await _auth.signOut();
//                   Navigator.pushReplacementNamed(context, LoginPage.id);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffC19A6B),
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Logout',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:cotton_app/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // 🔹 Bold text
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xffC19A6B),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: const Color(0xfff9f6f2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 👤 Profile Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xffC19A6B),
                child: const Icon(Icons.person, size: 45, color: Colors.white),
              ),
              const SizedBox(height: 20),

              // 🌟 Name and Email Box
              if (user != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person, color: Color(0xffC19A6B)),
                          const SizedBox(width: 8),
                          Text(
                            user.displayName ?? "User",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.email, color: Color(0xffC19A6B)),
                          const SizedBox(width: 8),
                          Text(
                            user.email ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5A5A5A), // 🔹 Slightly richer grey
                              decoration: TextDecoration.underline, // 🔹 Underlined
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 40),

              // 🚪 Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC19A6B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

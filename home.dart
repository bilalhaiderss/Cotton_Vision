import 'package:cotton_app/desisedect.dart';
import 'package:cotton_app/groth.dart';
import 'package:flutter/material.dart';
import 'package:cotton_app/cotton_facts_page.dart';
import 'package:cotton_app/farming_tips.dart';
import 'package:cotton_app/market_rates.dart';

class HomePage extends StatelessWidget {
  static const id = 'HomePage';

  final List<Map<String, dynamic>> horizontalCards = [
    {
      'title': 'Cotton Facts',
      'icon': Icons.info,
      'color': Colors.teal,
    },
    {
      'title': 'Farming Tips',
      'icon': Icons.agriculture,
      'color': Colors.green,
    },
    {
      'title': 'Market Rates',
      'icon': Icons.attach_money,
      'color': Colors.purple,
    },
  ];

  void handleCardTap(BuildContext context, String title) {
    if (title == 'Cotton Facts') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CottonFactsPage()),
      );
    } else if (title == 'Farming Tips') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FarmingTipsPage()),
      );
    } else if (title == 'Market Rates') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MarketRatesPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cotton Care Hub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Circles under the title
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(12, (index) {
                    final iconsList = [
                      Icons.local_florist,
                      Icons.grass,
                      Icons.eco,
                      Icons.agriculture,
                      Icons.spa,
                      Icons.landscape,
                      Icons.nature,
                      Icons.filter_vintage,
                      Icons.grain,
                      Icons.waves,
                      Icons.sanitizer,
                      Icons.spa_outlined,
                    ];
                    final icon = iconsList[index % iconsList.length];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.lightGreen.shade200,
                        child: Icon(icon, size: 28, color: Colors.green.shade900),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 20),

              // Cotton Information Widget
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        "Cotton: The Heart of Textile's 🌍",  // Your requested text
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 94, 106, 111),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Horizontal Scrollable Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: horizontalCards.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: GestureDetector(
                        onTap: () => handleCardTap(context, item['title']),
                        child: Container(
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                            color: item['color'],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 30, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),

              // "Heal Your Cotton" text (added back to original position)
              Text(
                "Heal Your Cotton 🌿",  // Original text restored
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),

              SizedBox(height: 15),

              // Stylish Grid Boxes
              SizedBox(
                height: 200,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final isPrediction = index == 0;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => isPrediction
                                ? cobsgroth()
                                : CottonPredictionsPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isPrediction
                                ? [Colors.blue.shade300, Colors.blue.shade600]
                                : [Colors.deepOrange.shade300, Colors.deepOrange.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: isPrediction
                                  ? Colors.blue.withOpacity(0.4)
                                  : Colors.deepOrange.withOpacity(0.4),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isPrediction ? Icons.analytics : Icons.healing,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(height: 12),
                            Text(
                              isPrediction
                                  ? "Cotton Predictions"
                                  : "Diseases Detector",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black26,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







































// import 'package:cotton_app/desisedect.dart';
// import 'package:cotton_app/groth.dart';
// import 'package:flutter/material.dart';
// import 'package:cotton_app/cotton_facts_page.dart';
// import 'package:cotton_app/farming_tips.dart';
// import 'package:cotton_app/market_rates.dart';

// class HomePage extends StatelessWidget {
//   static const id = 'HomePage';

//   final List<Map<String, dynamic>> horizontalCards = [
//     {
//       'title': 'Cotton Facts',
//       'icon': Icons.info,
//       'color': Colors.teal,
//     },
//     {
//       'title': 'Farming Tips',
//       'icon': Icons.agriculture,
//       'color': Colors.green,
//     },
//     {
//       'title': 'Market Rates',
//       'icon': Icons.attach_money,
//       'color': Colors.purple,
//     },
//   ];

//   void handleCardTap(BuildContext context, String title) {
//     if (title == 'Cotton Facts') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => CottonFactsPage()),
//       );
//     } else if (title == 'Farming Tips') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => FarmingTipsPage()),
//       );
//     } else if (title == 'Market Rates') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => MarketRatesPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Cotton Care Hub",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.blueGrey,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.blueGrey),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.blue.shade50],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Circles under the title
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(12, (index) {
//                     final iconsList = [
//                       Icons.local_florist,
//                       Icons.grass,
//                       Icons.eco,
//                       Icons.agriculture,
//                       Icons.spa,
//                       Icons.landscape,
//                       Icons.nature,
//                       Icons.filter_vintage,
//                       Icons.grain,
//                       Icons.waves,
//                       Icons.sanitizer,
//                       Icons.spa_outlined,
//                     ];
//                     final icon = iconsList[index % iconsList.length];
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 12.0),
//                       child: CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.lightGreen.shade200,
//                         child: Icon(icon, size: 28, color: Colors.green.shade900),
//                       ),
//                     );
//                   }),
//                 ),
//               ),

//               SizedBox(height: 20),

//               // Cotton Information Widget (replaced date/location)
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 elevation: 5,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Cotton: The Heart of Textiles",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: const Color.fromARGB(255, 94, 106, 111),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "A nurturer's pride, a craftsman's joy—cotton wraps the world in comfort and style.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),

//               // Horizontal Scrollable Cards
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: horizontalCards.map((item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 12.0),
//                       child: GestureDetector(
//                         onTap: () => handleCardTap(context, item['title']),
//                         child: Container(
//                           width: 140,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             color: item['color'],
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 5,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(item['icon'], size: 30, color: Colors.white),
//                               SizedBox(height: 8),
//                               Text(
//                                 item['title'],
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),

//               SizedBox(height: 20),

//               Text(
//                 "Heal Your Cotton 🌿",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueGrey,
//                 ),
//               ),

//               SizedBox(height: 15),

//               // Stylish Grid Boxes
//               SizedBox(
//                 height: 200,
//                 child: GridView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 2,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 15.0,
//                     mainAxisSpacing: 15.0,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     final isPrediction = index == 0;
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => isPrediction
//                                 ? cobsgroth()
//                                 : CottonPredictionsPage(),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: isPrediction
//                                 ? [Colors.blue.shade300, Colors.blue.shade600]
//                                 : [Colors.deepOrange.shade300, Colors.deepOrange.shade600],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: isPrediction
//                                   ? Colors.blue.withOpacity(0.4)
//                                   : Colors.deepOrange.withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               isPrediction ? Icons.analytics : Icons.healing,
//                               color: Colors.white,
//                               size: 50,
//                             ),
//                             SizedBox(height: 12),
//                             Text(
//                               isPrediction
//                                   ? "Cotton Predictions"
//                                   : "Diseases Detector",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 4,
//                                     color: Colors.black26,
//                                     offset: Offset(1, 1),
//                                   )
//                                 ],
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





























// // // // import 'package:cotton_app/desisedect.dart';
// // // // import 'package:cotton_app/groth.dart';
// // // // import 'package:flutter/material.dart';

// // // // class HomePage extends StatelessWidget {
// // // //   static const id = 'HomePage';

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text("Home Page"), centerTitle: true),
// // // //       body: Padding(
// // // //         padding: EdgeInsets.all(16.0),
// // // //         child: GridView.builder(
// // // //           itemCount: 2,
// // // //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // // //             crossAxisCount: 2, // 2 grid items in a row
// // // //             crossAxisSpacing: 10.0,
// // // //             mainAxisSpacing: 10.0,
// // // //           ),
// // // //           itemBuilder: (context, index) {
// // // //             return GestureDetector(
// // // //               onTap: () {
// // // //                 // Navigate to the respective page when the box is tapped
// // // //                 if (index == 0) {
// // // //                   Navigator.push(
// // // //                     context,
// // // //                     MaterialPageRoute(builder: (context) => cobsgroth()),
// // // //                   );
// // // //                 } else {
// // // //                   Navigator.push(
// // // //                     context,
// // // //                     MaterialPageRoute(
// // // //                       builder: (context) => CottonPredictionsPage(),
// // // //                     ),
// // // //                   );
// // // //                 }
// // // //               },
// // // //               child: Container(
// // // //                 padding: EdgeInsets.all(20.0),
// // // //                 decoration: BoxDecoration(
// // // //                   color:
// // // //                       index == 0 ? Colors.lightBlueAccent : Colors.orangeAccent,
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                   boxShadow: [
// // // //                     BoxShadow(
// // // //                       color: Colors.black26,
// // // //                       offset: Offset(0, 4),
// // // //                       blurRadius: 6,
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //                 child: Center(
// // // //                   child: Text(
// // // //                     index == 0 ? "Cotton Predictions" : "Diseases Detector",
// // // //                     style: TextStyle(
// // // //                       fontSize: 18,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }




























// // // // code to add then with animation 

// // // import 'package:cotton_app/desisedect.dart';
// // // import 'package:cotton_app/groth.dart';
// // // import 'package:flutter/material.dart';

// // // class HomePage extends StatelessWidget {
// // //   static const id = 'HomePage';

// // //   final List<Map<String, dynamic>> horizontalCards = [
// // //     {
// // //       'title': 'Cotton Facts',
// // //       'icon': Icons.info,
// // //       'color': Colors.teal,
// // //     },
// // //     {
// // //       'title': 'Farming Tips',
// // //       'icon': Icons.agriculture,
// // //       'color': Colors.green,
// // //     },
// // //     {
// // //       'title': 'Weather Today',
// // //       'icon': Icons.wb_sunny,
// // //       'color': Colors.orange,
// // //     },
// // //     {
// // //       'title': 'Market Rates',
// // //       'icon': Icons.attach_money,
// // //       'color': Colors.purple,
// // //     },
// // //     {
// // //       'title': 'Support',
// // //       'icon': Icons.support_agent,
// // //       'color': Colors.redAccent,
// // //     },
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final String fixedDate = 'Saturday, May 18, 2025';

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(
// // //           "Cotton Care Hub",
// // //           style: TextStyle(
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.blueGrey,
// // //           ),
// // //         ),
// // //         centerTitle: true,
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         iconTheme: IconThemeData(color: Colors.blueGrey),
// // //       ),
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             colors: [Colors.white, Colors.blue.shade50],
// // //             begin: Alignment.topCenter,
// // //             end: Alignment.bottomCenter,
// // //           ),
// // //         ),
// // //         child: Padding(
// // //           padding: EdgeInsets.all(16.0),
// // //           child: Column(
// // //             children: [
// // //               // Circles under the title
// // //               SingleChildScrollView(
// // //                 scrollDirection: Axis.horizontal,
// // //                 child: Row(
// // //                   children: List.generate(12, (index) {
// // //                     final iconsList = [
// // //                       Icons.local_florist,
// // //                       Icons.grass,
// // //                       Icons.eco,
// // //                       Icons.agriculture,
// // //                       Icons.spa,
// // //                       Icons.landscape,
// // //                       Icons.nature,
// // //                       Icons.filter_vintage,
// // //                       Icons.grain,
// // //                       Icons.waves,
// // //                       Icons.sanitizer,
// // //                       Icons.spa_outlined,
// // //                     ];
// // //                     final icon = iconsList[index % iconsList.length];
// // //                     return Padding(
// // //                       padding: const EdgeInsets.only(right: 12.0),
// // //                       child: CircleAvatar(
// // //                         radius: 28,
// // //                         backgroundColor: Colors.lightGreen.shade200,
// // //                         child: Icon(icon, size: 28, color: Colors.green.shade900),
// // //                       ),
// // //                     );
// // //                   }),
// // //                 ),
// // //               ),

// // //               SizedBox(height: 20),

// // //               // Weather Card
// // //               Card(
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(15),
// // //                 ),
// // //                 elevation: 5,
// // //                 color: Colors.white,
// // //                 child: Padding(
// // //                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
// // //                   child: Column(
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
// // //                           SizedBox(width: 10),
// // //                           Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               Text(
// // //                                 fixedDate,
// // //                                 style: TextStyle(
// // //                                   fontSize: 16,
// // //                                   fontWeight: FontWeight.bold,
// // //                                 ),
// // //                               ),
// // //                               Text(
// // //                                 "28°C • Sunny",
// // //                                 style: TextStyle(fontSize: 14, color: Colors.grey[700]),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       SizedBox(height: 10),
// // //                       Row(
// // //                         children: [
// // //                           Icon(Icons.location_on, color: Colors.redAccent),
// // //                           SizedBox(width: 4),
// // //                           Text(
// // //                             "Faisalabad, Pakistan",
// // //                             style: TextStyle(color: Colors.grey[600]),
// // //                           ),
// // //                         ],
// // //                       )
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),

// // //               SizedBox(height: 20),

// // //               // Horizontal Scrollable Cards
// // //               SingleChildScrollView(
// // //                 scrollDirection: Axis.horizontal,
// // //                 child: Row(
// // //                   children: horizontalCards.map((item) {
// // //                     return Padding(
// // //                       padding: const EdgeInsets.only(right: 12.0),
// // //                       child: Container(
// // //                         width: 140,
// // //                         height: 100,
// // //                         decoration: BoxDecoration(
// // //                           color: item['color'],
// // //                           borderRadius: BorderRadius.circular(15),
// // //                           boxShadow: [
// // //                             BoxShadow(
// // //                               color: Colors.black26,
// // //                               blurRadius: 5,
// // //                               offset: Offset(0, 3),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         child: Column(
// // //                           mainAxisAlignment: MainAxisAlignment.center,
// // //                           children: [
// // //                             Icon(item['icon'], size: 30, color: Colors.white),
// // //                             SizedBox(height: 8),
// // //                             Text(
// // //                               item['title'],
// // //                               textAlign: TextAlign.center,
// // //                               style: TextStyle(
// // //                                 color: Colors.white,
// // //                                 fontWeight: FontWeight.bold,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     );
// // //                   }).toList(),
// // //                 ),
// // //               ),

// // //               SizedBox(height: 20),

// // //               Text(
// // //                 "Heal Your Cotton 🌿",
// // //                 style: TextStyle(
// // //                   fontSize: 22,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Colors.blueGrey,
// // //                 ),
// // //               ),

// // //               SizedBox(height: 15),

// // //               // Stylish Grid Boxes
// // //               SizedBox(
// // //                 height: 200,
// // //                 child: GridView.builder(
// // //                   physics: NeverScrollableScrollPhysics(),
// // //                   itemCount: 2,
// // //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // //                     crossAxisCount: 2,
// // //                     crossAxisSpacing: 15.0,
// // //                     mainAxisSpacing: 15.0,
// // //                     childAspectRatio: 1,
// // //                   ),
// // //                   itemBuilder: (context, index) {
// // //                     final isPrediction = index == 0;
// // //                     return GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (_) => isPrediction
// // //                                 ? cobsgroth()
// // //                                 : CottonPredictionsPage(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: Container(
// // //                         padding: EdgeInsets.all(16),
// // //                         decoration: BoxDecoration(
// // //                           gradient: LinearGradient(
// // //                             colors: isPrediction
// // //                                 ? [Colors.blue.shade300, Colors.blue.shade600]
// // //                                 : [Colors.deepOrange.shade300, Colors.deepOrange.shade600],
// // //                             begin: Alignment.topLeft,
// // //                             end: Alignment.bottomRight,
// // //                           ),
// // //                           borderRadius: BorderRadius.circular(20),
// // //                           boxShadow: [
// // //                             BoxShadow(
// // //                               color: isPrediction
// // //                                   ? Colors.blue.withOpacity(0.4)
// // //                                   : Colors.deepOrange.withOpacity(0.4),
// // //                               blurRadius: 12,
// // //                               offset: Offset(0, 6),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         child: Column(
// // //                           mainAxisAlignment: MainAxisAlignment.center,
// // //                           children: [
// // //                             Icon(
// // //                               isPrediction ? Icons.analytics : Icons.healing,
// // //                               color: Colors.white,
// // //                               size: 50,
// // //                             ),
// // //                             SizedBox(height: 12),
// // //                             Text(
// // //                               isPrediction
// // //                                   ? "Cotton Predictions"
// // //                                   : "Diseases Detector",
// // //                               style: TextStyle(
// // //                                 fontSize: 18,
// // //                                 fontWeight: FontWeight.w600,
// // //                                 color: Colors.white,
// // //                                 shadows: [
// // //                                   Shadow(
// // //                                     blurRadius: 4,
// // //                                     color: Colors.black26,
// // //                                     offset: Offset(1, 1),
// // //                                   )
// // //                                 ],
// // //                               ),
// // //                               textAlign: TextAlign.center,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }




































// // import 'package:cotton_app/desisedect.dart';
// // import 'package:cotton_app/groth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cotton_app/cotton_facts_page.dart';
// // import 'package:cotton_app/farming_tips.dart';
// // import 'package:cotton_app/market_rates.dart';

// // class HomePage extends StatelessWidget {
// //   static const id = 'HomePage';

// //   final List<Map<String, dynamic>> horizontalCards = [
// //     {
// //       'title': 'Cotton Facts',
// //       'icon': Icons.info,
// //       'color': Colors.teal,
// //     },
// //     {
// //       'title': 'Farming Tips',
// //       'icon': Icons.agriculture,
// //       'color': Colors.green,
// //     },
// //     {
// //       'title': 'Market Rates',
// //       'icon': Icons.attach_money,
// //       'color': Colors.purple,
// //     },
// //   ];

// //   void handleCardTap(BuildContext context, String title) {
// //     if (title == 'Cotton Facts') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => CottonFactsPage()),
// //       );
// //     } else if (title == 'Farming Tips') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => FarmingTipsPage()),
// //       );
// //     } else if (title == 'Market Rates') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => MarketRatesPage()),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final String fixedDate = 'Saturday, May 18, 2025';

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Cotton Care Hub",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.blueGrey,
// //           ),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         iconTheme: IconThemeData(color: Colors.blueGrey),
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Colors.white, Colors.blue.shade50],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //         ),
// //         child: Padding(
// //           padding: EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               // Circles under the title
// //               SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: List.generate(12, (index) {
// //                     final iconsList = [
// //                       Icons.local_florist,
// //                       Icons.grass,
// //                       Icons.eco,
// //                       Icons.agriculture,
// //                       Icons.spa,
// //                       Icons.landscape,
// //                       Icons.nature,
// //                       Icons.filter_vintage,
// //                       Icons.grain,
// //                       Icons.waves,
// //                       Icons.sanitizer,
// //                       Icons.spa_outlined,
// //                     ];
// //                     final icon = iconsList[index % iconsList.length];
// //                     return Padding(
// //                       padding: const EdgeInsets.only(right: 12.0),
// //                       child: CircleAvatar(
// //                         radius: 28,
// //                         backgroundColor: Colors.lightGreen.shade200,
// //                         child: Icon(icon, size: 28, color: Colors.green.shade900),
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // Weather/Date Card
// //               Card(
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //                 elevation: 5,
// //                 color: Colors.white,
// //                 child: Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         children: [
// //                           Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
// //                           SizedBox(width: 10),
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 fixedDate,
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 "28°C • Sunny",
// //                                 style: TextStyle(fontSize: 14, color: Colors.grey[700]),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: 10),
// //                       Row(
// //                         children: [
// //                           Icon(Icons.location_on, color: Colors.redAccent),
// //                           SizedBox(width: 4),
// //                           Text(
// //                             "Faisalabad, Pakistan",
// //                             style: TextStyle(color: Colors.grey[600]),
// //                           ),
// //                         ],
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // Horizontal Scrollable Cards
// //               SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: horizontalCards.map((item) {
// //                     return Padding(
// //                       padding: const EdgeInsets.only(right: 12.0),
// //                       child: GestureDetector(
// //                         onTap: () => handleCardTap(context, item['title']),
// //                         child: Container(
// //                           width: 140,
// //                           height: 100,
// //                           decoration: BoxDecoration(
// //                             color: item['color'],
// //                             borderRadius: BorderRadius.circular(15),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.black26,
// //                                 blurRadius: 5,
// //                                 offset: Offset(0, 3),
// //                               ),
// //                             ],
// //                           ),
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(item['icon'], size: 30, color: Colors.white),
// //                               SizedBox(height: 8),
// //                               Text(
// //                                 item['title'],
// //                                 textAlign: TextAlign.center,
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               Text(
// //                 "Heal Your Cotton 🌿",
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blueGrey,
// //                 ),
// //               ),

// //               SizedBox(height: 15),

// //               // Stylish Grid Boxes
// //               SizedBox(
// //                 height: 200,
// //                 child: GridView.builder(
// //                   physics: NeverScrollableScrollPhysics(),
// //                   itemCount: 2,
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     crossAxisSpacing: 15.0,
// //                     mainAxisSpacing: 15.0,
// //                     childAspectRatio: 1,
// //                   ),
// //                   itemBuilder: (context, index) {
// //                     final isPrediction = index == 0;
// //                     return GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (_) => isPrediction
// //                                 ? cobsgroth()
// //                                 : CottonPredictionsPage(),
// //                           ),
// //                         );
// //                       },
// //                       child: Container(
// //                         padding: EdgeInsets.all(16),
// //                         decoration: BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: isPrediction
// //                                 ? [Colors.blue.shade300, Colors.blue.shade600]
// //                                 : [Colors.deepOrange.shade300, Colors.deepOrange.shade600],
// //                             begin: Alignment.topLeft,
// //                             end: Alignment.bottomRight,
// //                           ),
// //                           borderRadius: BorderRadius.circular(20),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: isPrediction
// //                                   ? Colors.blue.withOpacity(0.4)
// //                                   : Colors.deepOrange.withOpacity(0.4),
// //                               blurRadius: 12,
// //                               offset: Offset(0, 6),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               isPrediction ? Icons.analytics : Icons.healing,
// //                               color: Colors.white,
// //                               size: 50,
// //                             ),
// //                             SizedBox(height: 12),
// //                             Text(
// //                               isPrediction
// //                                   ? "Cotton Predictions"
// //                                   : "Diseases Detector",
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: Colors.white,
// //                                 shadows: [
// //                                   Shadow(
// //                                     blurRadius: 4,
// //                                     color: Colors.black26,
// //                                     offset: Offset(1, 1),
// //                                   )
// //                                 ],
// //                               ),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }



















// // five icon wala code 
// // import 'package:cotton_app/desisedect.dart';
// // import 'package:cotton_app/groth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cotton_app/cotton_facts_page.dart';
// // import 'package:cotton_app/farming_tips.dart';
// // import 'package:cotton_app/market_rates.dart';

// // class HomePage extends StatelessWidget {
// //   static const id = 'HomePage';

// //   final List<Map<String, dynamic>> horizontalCards = [
// //     {
// //       'title': 'Cotton Facts',
// //       'icon': Icons.info,
// //       'color': Colors.teal,
// //     },
// //     {
// //       'title': 'Farming Tips',
// //       'icon': Icons.agriculture,
// //       'color': Colors.green,
// //     },
// //     {
// //       'title': 'Market Rates',
// //       'icon': Icons.attach_money,
// //       'color': Colors.purple,
// //     },
// //   ];

// //   void handleCardTap(BuildContext context, String title) {
// //     if (title == 'Cotton Facts') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => CottonFactsPage()),
// //       );
// //     } else if (title == 'Farming Tips') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => FarmingTipsPage()),
// //       );
// //     } else if (title == 'Market Rates') {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (_) => MarketRatesPage()),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Cotton Care Hub",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.blueGrey,
// //           ),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         iconTheme: IconThemeData(color: Colors.blueGrey),
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Colors.white, Colors.blue.shade50],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //         ),
// //         child: Padding(
// //           padding: EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               // Circles under the title - Now only 5 icons
// //               SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: List.generate(5, (index) {
// //                     final iconsList = [
// //                       Icons.local_florist,
// //                       Icons.grass,
// //                       Icons.eco,
// //                       Icons.agriculture,
// //                       Icons.spa,
// //                     ];
// //                     final icon = iconsList[index];
// //                     return Padding(
// //                       padding: const EdgeInsets.only(right: 12.0),
// //                       child: CircleAvatar(
// //                         radius: 28,
// //                         backgroundColor: Colors.lightGreen.shade200,
// //                         child: Icon(icon, size: 28, color: Colors.green.shade900),
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // Cotton Information Widget
// //               Card(
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //                 elevation: 5,
// //                 color: Colors.white,
// //                 child: Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
// //                   child: Column(
// //                     children: [
// //                       Text(
// //                         "Cotton: The Heart of Textiles",
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: const Color.fromARGB(255, 94, 106, 111),
// //                         ),
// //                       ),
// //                       SizedBox(height: 10),
// //                       Text(
// //                         "A nurturer's pride, a craftsman's joy—cotton wraps the world in comfort and style.",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 14,
// //                           color: Colors.grey[700],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // Horizontal Scrollable Cards
// //               SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: horizontalCards.map((item) {
// //                     return Padding(
// //                       padding: const EdgeInsets.only(right: 12.0),
// //                       child: GestureDetector(
// //                         onTap: () => handleCardTap(context, item['title']),
// //                         child: Container(
// //                           width: 140,
// //                           height: 100,
// //                           decoration: BoxDecoration(
// //                             color: item['color'],
// //                             borderRadius: BorderRadius.circular(15),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.black26,
// //                                 blurRadius: 5,
// //                                 offset: Offset(0, 3),
// //                               ),
// //                             ],
// //                           ),
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(item['icon'], size: 30, color: Colors.white),
// //                               SizedBox(height: 8),
// //                               Text(
// //                                 item['title'],
// //                                 textAlign: TextAlign.center,
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               Text(
// //                 "Heal Your Cotton 🌿",
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blueGrey,
// //                 ),
// //               ),

// //               SizedBox(height: 15),

// //               // Stylish Grid Boxes
// //               SizedBox(
// //                 height: 200,
// //                 child: GridView.builder(
// //                   physics: NeverScrollableScrollPhysics(),
// //                   itemCount: 2,
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     crossAxisSpacing: 15.0,
// //                     mainAxisSpacing: 15.0,
// //                     childAspectRatio: 1,
// //                   ),
// //                   itemBuilder: (context, index) {
// //                     final isPrediction = index == 0;
// //                     return GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (_) => isPrediction
// //                                 ? cobsgroth()
// //                                 : CottonPredictionsPage(),
// //                           ),
// //                         );
// //                       },
// //                       child: Container(
// //                         padding: EdgeInsets.all(16),
// //                         decoration: BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: isPrediction
// //                                 ? [Colors.blue.shade300, Colors.blue.shade600]
// //                                 : [Colors.deepOrange.shade300, Colors.deepOrange.shade600],
// //                             begin: Alignment.topLeft,
// //                             end: Alignment.bottomRight,
// //                           ),
// //                           borderRadius: BorderRadius.circular(20),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: isPrediction
// //                                   ? Colors.blue.withOpacity(0.4)
// //                                   : Colors.deepOrange.withOpacity(0.4),
// //                               blurRadius: 12,
// //                               offset: Offset(0, 6),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               isPrediction ? Icons.analytics : Icons.healing,
// //                               color: Colors.white,
// //                               size: 50,
// //                             ),
// //                             SizedBox(height: 12),
// //                             Text(
// //                               isPrediction
// //                                   ? "Cotton Predictions"
// //                                   : "Diseases Detector",
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: Colors.white,
// //                                 shadows: [
// //                                   Shadow(
// //                                     blurRadius: 4,
// //                                     color: Colors.black26,
// //                                     offset: Offset(1, 1),
// //                                   )
// //                                 ],
// //                               ),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
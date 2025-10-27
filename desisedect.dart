// import 'dart:convert';
// import 'dart:io';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class TFLiteOutput {
//   final String label;
//   final double confidence;

//   TFLiteOutput({required this.label, this.confidence = 0.0});
// }

// class CottonPredictionsPage extends StatefulWidget {
//   const CottonPredictionsPage({Key? key}) : super(key: key);
//   static const id = 'CottonPredictionsPage';

//   @override
//   _CottonPredictionsPageState createState() => _CottonPredictionsPageState();
// }

// class _CottonPredictionsPageState extends State<CottonPredictionsPage>
//     with TickerProviderStateMixin {
//   File? _image;
//   final List<TFLiteOutput> _outputs = [];
//   bool _loading = false;
//   bool _imageSelected = false;

//   late AnimationController _buttonController;
//   late Animation<double> _buttonAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _buttonController = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );

//     _buttonAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//         CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut))
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _buttonController.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           _buttonController.forward();
//         }
//       });

//     _buttonController.forward();
//   }

//   @override
//   void dispose() {
//     _buttonController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker imagePicker = ImagePicker();
//     await showModalBottomSheet(
//       context: context,
//       builder: (context) => SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color(0xffC19A6B).withOpacity(0.9),
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Select an Image',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ListTile(
//                 leading: const Icon(Icons.photo, color: Colors.white),
//                 title: const Text('From Gallery',
//                     style: TextStyle(color: Colors.white)),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final XFile? image =
//                       await imagePicker.pickImage(source: ImageSource.gallery);
//                   _processImage(image);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera, color: Colors.white),
//                 title: const Text('From Camera',
//                     style: TextStyle(color: Colors.white)),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final XFile? image =
//                       await imagePicker.pickImage(source: ImageSource.camera);
//                   _processImage(image);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _processImage(XFile? imageFile) async {
//     if (imageFile != null) {
//       setState(() {
//         _image = File(imageFile.path);
//         _imageSelected = true;
//       });
//     } else {
//       print('No image selected.');
//     }
//   }

//   Future<void> _predictImage() async {
//     if (_image == null) return;

//     setState(() {
//       _loading = true;
//     });

//     // Update the URI to point to the correct endpoint
//     final uri = Uri.parse('http://192.168.100.73:8181/detectdisease');

//     final request = http.MultipartRequest('POST', uri);

//     try {
//       print('Adding file to request: ${_image!.path}');
//       request.files
//           .add(await http.MultipartFile.fromPath('file', _image!.path));

//       print('Sending request...');
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         String yieldCategory = data['yield_category'] ?? 'Unknown';
//         double confidence = (data['confidence'] ?? 0.0).toDouble();

//         setState(() {
//           _loading = false;
//           _outputs.clear();
//           _outputs.add(TFLiteOutput(
//             label: yieldCategory,
//             confidence: confidence,
//           ));
//         });

//         if (yieldCategory == 'Unknown') {
//           _showUnknownResultDialog();
//         } else {
//           Navigator.push(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation, secondaryAnimation) =>
//                   PredictionDisplayPage(outputs: _outputs),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 const begin = Offset(1.0, 0.0);
//                 const end = Offset.zero;
//                 const curve = Curves.easeInOut;

//                 var tween = Tween(begin: begin, end: end)
//                     .chain(CurveTween(curve: curve));
//                 var offsetAnimation = animation.drive(tween);

//                 return SlideTransition(
//                   position: offsetAnimation,
//                   child: child,
//                 );
//               },
//             ),
//           );
//         }
//       } else {
//         setState(() {
//           _loading = false;
//           _outputs.clear();
//           _outputs.add(TFLiteOutput(label: 'Unknown', confidence: 0.0));
//         });
//         _showUnknownResultDialog();
//       }
//     } catch (e) {
//       print('Failed to predict: $e');
//       setState(() {
//         _loading = false;
//         _outputs.clear();
//         _outputs.add(TFLiteOutput(label: 'Error', confidence: 0.0));
//       });
//       _showUnknownResultDialog();
//     }
//   }

//   void _showUnknownResultDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         backgroundColor: const Color(0xffC19A6B),
//         title: Row(
//           children: [
//             const Icon(Icons.error_outline, color: Colors.white),
//             const SizedBox(width: 10),
//             DefaultTextStyle(
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               child: AnimatedTextKit(
//                 animatedTexts: [
//                   WavyAnimatedText('Prediction Result'),
//                 ],
//                 isRepeatingAnimation: true,
//               ),
//             ),
//           ],
//         ),
//         content: const Text(
//           'The prediction result is unknown or an error occurred. Please try with another image.',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//         actions: [
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: const Color(0xffC19A6B),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text(
//               'OK',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Cotton Prediction'),
//           centerTitle: true,
//         ),
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Center(
//             child: _loading
//                 ? const CircularProgressIndicator()
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           height: MediaQuery.of(context).size.width * 0.8,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: const Color(0xffC19A6B),
//                               width: 3,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: _image == null
//                               ? const Center(
//                                   child: Text(
//                                     'Click the button to select an image',
//                                     style: TextStyle(
//                                       color: Color(0xffC19A6B),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 )
//                               : Image.file(
//                                   _image!,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       _imageSelected
//                           ? AnimatedBuilder(
//                               animation: _buttonAnimation,
//                               builder: (context, child) {
//                                 return Transform.scale(
//                                   scale: _buttonAnimation.value,
//                                   child: SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.6,
//                                     child: ElevatedButton(
//                                       onPressed: _predictImage,
//                                       style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor:
//                                             const Color(0xffC19A6B),
//                                       ),
//                                       child: const Text('Predict'),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : Container(),
//                       const SizedBox(height: 90),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _pickImage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xffC19A6B),
//                               padding: const EdgeInsets.all(20),
//                             ),
//                             child: const Text(
//                               "Select Image",
//                               style: TextStyle(color: Colors.white),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PredictionDisplayPage extends StatelessWidget {
//   final List<TFLiteOutput> outputs;

//   const PredictionDisplayPage({Key? key, required this.outputs})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Prediction Result'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Prediction: ${outputs[0].label}',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Confidence: ${(outputs[0].confidence * 100).toStringAsFixed(2)}%',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Diseases Detection'),
//           centerTitle: true,
//         ),
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Center(
//             child: _loading
//                 ? const CircularProgressIndicator()
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           height: MediaQuery.of(context).size.width * 0.8,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: const Color(0xffC19A6B),
//                               width: 3,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: _image == null
//                               ? const Center(
//                                   child: Text(
//                                     'Click the button to select an image',
//                                     style: TextStyle(
//                                       color: Color(0xffC19A6B),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 )
//                               : Image.file(
//                                   _image!,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       _imageSelected
//                           ? AnimatedBuilder(
//                               animation: _buttonAnimation,
//                               builder: (context, child) {
//                                 return Transform.scale(
//                                   scale: _buttonAnimation.value,
//                                   child: SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.6,
//                                     child: ElevatedButton(
//                                       onPressed: _predictImage,
//                                       style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor:
//                                             const Color(0xffC19A6B),
//                                       ),
//                                       child: const Text('Predict'),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           : Container(),
//                       const SizedBox(height: 90),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _pickImage,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xffC19A6B),
//                               padding: const EdgeInsets.all(20),
//                             ),
//                             child: const Text(
//                               "Select Image",
//                               style: TextStyle(color: Colors.white),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }













import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TFLiteOutput {
  final String label;
  final double confidence;

  TFLiteOutput({required this.label, this.confidence = 0.0});
}

class CottonPredictionsPage extends StatefulWidget {
  const CottonPredictionsPage({Key? key}) : super(key: key);
  static const id = 'CottonPredictionsPage';

  @override
  _CottonPredictionsPageState createState() => _CottonPredictionsPageState();
}

class _CottonPredictionsPageState extends State<CottonPredictionsPage>
    with TickerProviderStateMixin {
  File? _image;
  final List<TFLiteOutput> _outputs = [];
  bool _loading = false;
  bool _imageSelected = false;

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
        CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
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

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    await showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffC19A6B).withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select an Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.white),
                title: const Text('From Gallery',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  _processImage(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera, color: Colors.white),
                title: const Text('From Camera',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  _processImage(image);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processImage(XFile? imageFile) async {
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
        _imageSelected = true;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _predictImage() async {
    if (_image == null) return;

    setState(() {
      _loading = true;
    });

    final uri = Uri.parse('http://10.93.249.209:8181/detectdisease');
    final request = http.MultipartRequest('POST', uri);

    try {
      print('Adding file to request: ${_image!.path}');
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));

      print('Sending request...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String yieldCategory = data['yield_category'] ?? 'Unknown';
        double confidence = (data['confidence'] ?? 0.0).toDouble();

        setState(() {
          _loading = false;
          _outputs.clear();
          _outputs.add(TFLiteOutput(
            label: yieldCategory,
            confidence: confidence,
          ));
        });

        if (yieldCategory == 'Unknown') {
          _showUnknownResultDialog();
        } else {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PredictionDisplayPage(outputs: _outputs, image: _image!),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      } else {
        setState(() {
          _loading = false;
          _outputs.clear();
          _outputs.add(TFLiteOutput(label: 'Unknown', confidence: 0.0));
        });
        _showUnknownResultDialog();
      }
    } catch (e) {
      print('Failed to predict: $e');
      setState(() {
        _loading = false;
        _outputs.clear();
        _outputs.add(TFLiteOutput(label: 'Error', confidence: 0.0));
      });
      _showUnknownResultDialog();
    }
  }

  void _showUnknownResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color(0xffC19A6B),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Prediction Result'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ),
        content: const Text(
          'The prediction result is unknown or an error occurred. Please try with another image.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffC19A6B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('🔍 Disease Detection'),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF9F5F2),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFFF5E1), Color(0xffF3D6B1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: _loading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          const SizedBox(height: 80),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xffC19A6B),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.brown.shade200,
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: _image == null
                                  ? const Center(
                                      child: Text(
                                        'Tap here to select an image',
                                        style: TextStyle(
                                          color: Color(0xffC19A6B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _imageSelected
                              ? AnimatedBuilder(
                                  animation: _buttonAnimation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _buttonAnimation.value,
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: ElevatedButton(
                                          onPressed: _predictImage,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xffC19A6B),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text(
                                            '🔍 Detect Disease',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _pickImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffC19A6B),
                                  padding: const EdgeInsets.all(18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                icon: const Icon(Icons.image, color: Colors.white),
                                label: const Text(
                                  "Choose Image Again",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionDisplayPage extends StatefulWidget {
  final List<TFLiteOutput> outputs;
  final File image;

  const PredictionDisplayPage(
      {Key? key, required this.outputs, required this.image})
      : super(key: key);

  @override
  _PredictionDisplayPageState createState() => _PredictionDisplayPageState();
}

class _PredictionDisplayPageState extends State<PredictionDisplayPage> {
  bool _isLoadingGemini = false;

  Future<void> _getGeminiDiagnosis() async {
    setState(() {
      _isLoadingGemini = true;
    });

    final gemini = Gemini.instance;

    try {
      final response = await gemini.textAndImage(
        text:
            '''Analyze the image of the cotton plant and determine if it is healthy or diseased. 
            If healthy, confirm the plant is fine. If diseased, identify the specific disease (e.g., bacterial blight, fusarium wilt, boll rot) based on visible symptoms and provide a concise explanation of the disease (including symptoms) and a practical solution (e.g., treatment or management practices). 
            Keep the response clear and actionable.''',
        images: [widget.image.readAsBytesSync()],
        safetySettings: [
          SafetySetting(
            category: SafetyCategory.harassment,
            threshold: SafetyThreshold.blockLowAndAbove,
          ),
          SafetySetting(
            category: SafetyCategory.hateSpeech,
            threshold: SafetyThreshold.blockOnlyHigh,
          ),
        ],
        generationConfig: GenerationConfig(
          temperature: 0.7,
          maxOutputTokens: 256,
        ),
      );

      // Debug the response structure
      print('Gemini response: $response');
      print('Content: ${response?.content}');
      print('Parts: ${response?.content?.parts}');

      String diagnosis;
      if (response != null &&
          response.content != null &&
          response.content!.parts != null &&
          response.content!.parts!.isNotEmpty) {
        final part = response.content!.parts!.last;
        if (part is TextPart) {
          diagnosis = part.text ?? 'No diagnosis available.';
        } else {
          diagnosis = 'Unexpected part type: ${part.runtimeType}';
        }
      } else {
        diagnosis = 'No diagnosis received. Please try again.';
      }

      print("Details: $diagnosis");
      _showDiagnosisDialog(diagnosis);
    } catch (e) {
      print("Error fetching diagnosis from Gemini: $e");
      _showDiagnosisDialog('Failed to fetch diagnosis: $e');
    } finally {
      setState(() {
        _isLoadingGemini = false;
      });
    }
  }

  void _showDiagnosisDialog(String diagnosis) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color(0xffC19A6B),
        title: Row(
          children: [
            const Icon(Icons.medical_services, color: Colors.white),
            const SizedBox(width: 10),
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Details'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            diagnosis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffC19A6B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Prediction: ${widget.outputs[0].label}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Confidence: ${(widget.outputs[0].confidence * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            _isLoadingGemini
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getGeminiDiagnosis,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xffC19A6B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text(
                      'Get Details',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'tflite_output.dart';

class PredictionDisplayPage extends StatefulWidget {
  final List<TFLiteOutput> output;
  final File image;

  const PredictionDisplayPage(
      {Key? key, required this.output, required this.image})
      : super(key: key);

  @override
  _PredictionDisplayPageState createState() => _PredictionDisplayPageState();
}

class _PredictionDisplayPageState extends State<PredictionDisplayPage> {
  bool _isLoadingGemini = false;

  Future<void> _getGeminiGrowthAnalysis() async {
    setState(() {
      _isLoadingGemini = true;
    });

    final gemini = Gemini.instance;

    try {
      final response = await gemini.textAndImage(
        text:
            '''Analyze the image of the cotton plant and determine its growth stage (e.g., vegetative, flowering, boll development) and overall health. 
            If the plant is healthy and growing well, confirm its condition and suggest maintenance practices. 
            If the growth is suboptimal or the plant shows signs of stress (e.g., stunted growth, yellowing leaves), identify the likely cause and provide a concise explanation along with practical recommendations (e.g., irrigation, fertilization, pest control). 
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

      print('Gemini response: $response');
      print('Content: ${response?.content}');
      print('Parts: ${response?.content?.parts}');

      String analysis;
      if (response != null &&
          response.content != null &&
          response.content!.parts != null &&
          response.content!.parts!.isNotEmpty) {
        final part = response.content!.parts!.last;
        if (part is TextPart) {
          analysis = part.text ?? 'No analysis available.';
        } else {
          analysis = 'Unexpected part type: ${part.runtimeType}';
        }
      } else {
        analysis = 'No analysis received. Please try again.';
      }

      print("Gemini's analysis: $analysis");
      _showAnalysisDialog(analysis);
    } catch (e) {
      print("Error fetching analysis from Gemini: $e");
      _showAnalysisDialog('Failed to fetch analysis: $e');
    } finally {
      setState(() {
        _isLoadingGemini = false;
      });
    }
  }

  void _showAnalysisDialog(String analysis) {
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
                  WavyAnimatedText(' Growth Analysis'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            analysis,
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
    final prediction = widget.output.isNotEmpty ? widget.output[0] : null;

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
              'API Prediction: ${prediction?.label ?? 'Unknown'}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Confidence is commented out in TFLiteOutput, so exclude it
            // Text(
            //   'Confidence: ${(prediction?.confidence ?? 0.0 * 100).toStringAsFixed(2)}%',
            //   style: const TextStyle(fontSize: 18),
            // ),
            const SizedBox(height: 20),
            _isLoadingGemini
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getGeminiGrowthAnalysis,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xffC19A6B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text(
                      'Get Growth Analysis',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

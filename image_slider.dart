import 'dart:async';

import 'package:flutter/material.dart';

class ImageSliderPage extends StatefulWidget {
  const ImageSliderPage({Key? key}) : super(key: key);

  @override
  _ImageSliderPageState createState() => _ImageSliderPageState();
}

class _ImageSliderPageState extends State<ImageSliderPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  final int _numPages = 8;
  late Timer _timer; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPageIndex < _numPages - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
 @override
Widget build(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      children: [
        Image.asset('lib/assets/sample_images/1.jpg'),
        Image.asset('lib/assets/sample_images/2.jpg'),
        Image.asset('lib/assets/sample_images/3.jpg'),
        Image.asset('lib/assets/sample_images/4.png'),
        Image.asset('lib/assets/sample_images/10.png'),
        Image.asset('lib/assets/sample_images/11.png'),
        Image.asset('lib/assets/sample_images/9.png'),
        Image.asset('lib/assets/sample_images/10.png'),
        Image.asset('lib/assets/sample_images/9.png'),
        Image.asset('lib/assets/sample_images/10.png'),
        Image.asset('lib/assets/sample_images/11.png'),
        // Image.asset('lib/assets/sample_images/1.png'),
        // Image.asset('lib/assets/sample_images/1.png'),

      ],
    ),
  );
}
}
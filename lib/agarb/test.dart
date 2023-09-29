import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCarouselPage(),
    );
  }
}

class MyCarouselPage extends StatefulWidget {
  @override
  _MyCarouselPageState createState() => _MyCarouselPageState();
}

class _MyCarouselPageState extends State<MyCarouselPage> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  bool _isAutoScrollingPaused = false;

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  void startAutoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!_isAutoScrollingPaused) {
        _carouselController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        startAutoScroll();
      }
    });
  }

  void pauseAutoScroll() {
    setState(() {
      _isAutoScrollingPaused = true;
    });
  }

  void resumeAutoScroll() {
    setState(() {
      _isAutoScrollingPaused = false;
      startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: 5, // Change this to the number of items in your carousel
            carouselController: _carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'Item $index',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Current Index: $_currentIndex',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  pauseAutoScroll();
                  _carouselController.animateToPage(2).then((_) {
                    resumeAutoScroll();
                  });
                },
                child: const Text('Scroll to Index 2'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Pause auto-scrolling and scroll to a different index (e.g., index 4)
                  pauseAutoScroll();
                  _carouselController.animateToPage(4).then((_) {
                    // Resume auto-scrolling after scrolling to the desired index
                    resumeAutoScroll();
                  });
                },
                child: const Text('Scroll to Index 4'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

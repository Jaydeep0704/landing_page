import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebLandingScreen(),
    );
  }
}

class WebLandingScreen extends StatefulWidget {
  const WebLandingScreen({super.key});

  @override
  _WebLandingScreenState createState() => _WebLandingScreenState();
}

class _WebLandingScreenState extends State<WebLandingScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(int index) {
    final RenderObject? sectionRenderObject =
    _sectionKeys[index].currentContext?.findRenderObject();

    if (sectionRenderObject != null) {
      _scrollController.animateTo(
        sectionRenderObject.semanticBounds.top,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  final List<GlobalKey> _sectionKeys = List.generate(
    5,
        (index) => GlobalKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Example')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            key: _sectionKeys[index],
            height: 200,
            color: Colors.grey[(index + 1) * 100],
            child: Center(
              child: ElevatedButton(
                onPressed: () => _scrollToSection(index == 2 ? 0 : 2),
                child: Text('Scroll to Section ${index == 2 ? 0 : 2}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

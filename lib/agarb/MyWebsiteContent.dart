import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Website'),
        ),
        // body: MyWebsiteContent(),
        body: Screennnnn(),
      ),
    );
  }
}

class MyWebsiteContent extends StatefulWidget {
  @override
  _MyWebsiteContentState createState() => _MyWebsiteContentState();
}

class _MyWebsiteContentState extends State<MyWebsiteContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            // Scroll up
            _scroll(-50);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            // Scroll down
            _scroll(50);
          }
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            Container(
              height: 2000, // Adjust the height of your content
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                'Scrollable Content',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scroll(double offset) {
    // Scroll the content by the given offset
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

class Screennnnn extends StatefulWidget {
  const Screennnnn({super.key});

  @override
  State<Screennnnn> createState() => _ScreennnnnState();
}

class _ScreennnnnState extends State<Screennnnn> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        radius: const Radius.circular(20),
        thumbColor: Colors.blue,
        controller: _scrollController,
        trackVisibility: true,
        thickness: 15,
        interactive: true,
        thumbVisibility: true,
        child: ListView(
          primary: true,
          children: [
            Container(
              height: 500,
              color: Colors.red,
            ),
            Container(
              height: 500,
              color: Colors.green,
            ),
            Container(
              height: 500,
              color: Colors.black,
            ),
            Container(
              height: 500,
              color: Colors.white,
            ),
            Container(
              height: 500,
              color: Colors.red,
            ),
            Container(
              height: 500,
              color: Colors.green,
            ),
            Container(
              height: 500,
              color: Colors.black,
            ),
            Container(
              height: 500,
              color: Colors.white,
            ),
            Container(
              height: 500,
              color: Colors.red,
            ),
            Container(
              height: 500,
              color: Colors.green,
            ),
            Container(
              height: 500,
              color: Colors.black,
            ),
            Container(
              height: 500,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

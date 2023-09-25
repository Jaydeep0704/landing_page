import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(ScrollableApp(
  child: const ThisApp(),
));

class ScrollableApp extends StatelessWidget {
  final Widget child;

  ScrollableApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardScrollableScreen(
        child: child,
      ),
      routes: {
        '/second_screen': (context) => const SecondScreen(),
      },
    );
  }
}

class KeyboardScrollableScreen extends StatefulWidget {
  final Widget child;

  KeyboardScrollableScreen({super.key, required this.child});

  @override
  _KeyboardScrollableScreenState createState() =>
      _KeyboardScrollableScreenState();
}

class _KeyboardScrollableScreenState extends State<KeyboardScrollableScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _scrollController.animateTo(
              _scrollController.offset - 100.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _scrollController.animateTo(
              _scrollController.offset + 100.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: widget.child,
      ),
    );
  }
}

class ThisApp extends StatelessWidget {
  const ThisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrollable App Sample')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is your app content.'),
            const Text('You can navigate to different screens.'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second_screen');
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('This is the second screen.'),
            Text('You can scroll this screen using arrow keys.'),
          ],
        ),
      ),
    );
  }
}


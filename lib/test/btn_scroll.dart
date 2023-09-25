import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const ScrollScreenApp());

class ScrollScreenApp extends StatelessWidget {
  const ScrollScreenApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Scroll Screen Sample')),
        body: const Center(
          child: ScrollScreenExample(),
        ),
      ),
    );
  }
}

class ScrollScreenExample extends StatefulWidget {
  const ScrollScreenExample({Key? key});

  @override
  State<ScrollScreenExample> createState() => _ScrollScreenExampleState();
}

class _ScrollScreenExampleState extends State<ScrollScreenExample> {
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
        child: Column(
          children: const <Widget>[
            ListTile(
              title: Text('Scroll Screen Up/Down'),
            ),
            ListTile(
              title: Text('Item 1'),
            ),
            ListTile(
              title: Text('Item 2'),
            ),
            ListTile(
              title: Text('Item 3'),
            ),
            ListTile(
              title: Text('Item 4'),
            ),
            ListTile(
              title: Text('Item 5'),
            ),
            ListTile(
              title: Text('Item 6'),
            ),
            ListTile(
              title: Text('Item 7'),
            ),
            ListTile(
              title: Text('Item 8'),
            ),
            ListTile(
              title: Text('Item 9'),
            ),
            ListTile(
              title: Text('Item 10'),
            ),
          ],
        ),
      ),
    );
  }
}

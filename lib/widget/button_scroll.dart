import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KeyboardScroll {
  static void addScrollListener(ScrollController controller) {
    RawKeyboard.instance.addListener((RawKeyEvent event) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          _scrollListView(controller, -1);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          _scrollListView(controller, 1);
        }
      }
    });
  }

  static void removeScrollListener() {
    RawKeyboard.instance.removeListener((RawKeyEvent event) {
      // Remove the listener when needed
    });
  }

  static void _scrollListView(ScrollController controller, int direction) {
    final double scrollAmount =
        direction * 100.0; // Adjust the scroll amount as needed
    controller.animateTo(
      controller.offset + scrollAmount,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}

///Exmaple

class TestScrolling extends StatefulWidget {
  @override
  _TestScrollingState createState() => _TestScrollingState();
}

class _TestScrollingState extends State<TestScrolling> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    KeyboardScroll.addScrollListener(_controller);
  }

  @override
  void dispose() {
    KeyboardScroll.removeScrollListener();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll ListView with Arrow Keys'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: 100, // Adjust as needed
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    );
  }
}

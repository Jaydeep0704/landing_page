///
import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/widget/button_scroll.dart';

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

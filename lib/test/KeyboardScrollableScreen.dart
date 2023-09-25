// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardScrollableScreen extends StatefulWidget {
  final Widget child;

  const KeyboardScrollableScreen({super.key, required this.child});

  @override
  _KeyboardScrollableScreenState createState() =>
      _KeyboardScrollableScreenState();
}

class _KeyboardScrollableScreenState extends State<KeyboardScrollableScreen> {
  // ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: scrollMethod,
      child: SingleChildScrollView(
        controller: scrollController,
        child: widget.child,
      ),
    );
  }
}

ScrollController scrollController = ScrollController();

void scrollMethod(RawKeyEvent event) {
  if (event is RawKeyDownEvent) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      scrollController.animateTo(
        scrollController.offset - 100.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      scrollController.animateTo(
        scrollController.offset + 100.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }
}

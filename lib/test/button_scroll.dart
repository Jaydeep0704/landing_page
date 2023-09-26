// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
//
// class KeyboardScroll {
//   static void addScrollListener(ScrollController controller) {
//     RawKeyboard.instance.addListener((RawKeyEvent event) {
//       if (event is RawKeyDownEvent) {
//         if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
//           _scrollListView(controller, -1);
//         } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
//           _scrollListView(controller, 1);
//         }
//       }
//     });
//   }
//
//   static void removeScrollListener() {
//     RawKeyboard.instance.removeListener((RawKeyEvent event) {
//       // Remove the listener when needed
//     });
//   }
//
//   static void _scrollListView(ScrollController controller, int direction) {
//     final double scrollAmount =
//         direction * 100.0; // Adjust the scroll amount as needed
//     controller.animateTo(
//       controller.offset + scrollAmount,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeInOut,
//     );
//   }
// }

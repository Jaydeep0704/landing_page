// import 'package:flutter/material.dart';
// import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';
//
// class YourParentWidget extends StatefulWidget {
//   @override
//   _YourParentWidgetState createState() => _YourParentWidgetState();
// }
//
// class _YourParentWidgetState extends State<YourParentWidget> {
//   GlobalKey _pricingSectionKey = GlobalKey();
//   ScrollController _scrollController = ScrollController();
//
//   void scrollToPricingSection() {
//     final RenderBox renderBox = _pricingSectionKey.currentContext!.findRenderObject() as RenderBox;
//     final position = renderBox.localToGlobal(Offset.zero);
//     _scrollController.animateTo(
//       position.dy,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: editController.homeComponentList.length,
//       itemBuilder: (context, index) => Container(
//         key: ValueKey(editController.homeComponentList[index]),
//         child: getComponentUi(editController.homeComponentList[index]["component_name"]),
//       ),
//     );
//   }
//
//   Widget getComponentUi(homecomponent) {
//     if (homecomponent == "pricing") {
//       return PricingSection(key: _pricingSectionKey);
//     }
//     // ... other component conditions ...
//   }
// }
//
// class HelpBannerSection extends StatelessWidget {
//   final VoidCallback scrollToPricingSection;
//
//   HelpBannerSection({required this.scrollToPricingSection});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // ... other widget code ...
//
//         ElevatedButton(
//           onPressed: () {
//             // Call the method to scroll to PricingSection in the parent widget
//             scrollToPricingSection();
//           },
//           child: Text('Scroll to Pricing'),
//         ),
//       ],
//     );
//   }
// }
//

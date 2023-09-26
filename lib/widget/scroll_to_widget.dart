// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';
//
// class ScrollTo {
//   static scrollToPricingSection(ScrollController _scrollController) {
//     final RenderObject? pricingSectionRenderObject =
//         PricingSection.pricingSectionKey.currentContext?.findRenderObject();
//     if (pricingSectionRenderObject != null) {
//       _scrollController.animateTo(
//         _scrollController.position.pixels +
//             pricingSectionRenderObject.getTransformTo(null).getTranslation().y,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
// }

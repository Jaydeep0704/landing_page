import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double blur;
  final double borderRadius;
  final Color color;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final BoxBorder? border;

  const GlassmorphicContainer({
    Key? key,
    @required this.child,
    this.width,
    this.height,
    this.blur = 20,
    this.borderRadius = 20,
    this.color = Colors.white,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            gradient: LinearGradient(
              begin: gradientBegin,
              end: gradientEnd,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.2),
              ],
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

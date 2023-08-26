
import 'package:flutter/widgets.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';

commonDivider(
    {double? height, double? width, Color? color, EdgeInsets? margin,EdgeInsets? padding}) {
  return Container(
    height: height ?? 1,
    width: width ?? 1,
    color: color ?? AppColors.greyBorderColor,
    margin: margin,
    padding: padding,
  );
}

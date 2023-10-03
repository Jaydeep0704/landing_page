import 'package:flutter/material.dart';

commonIconButton(
    {EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    String? title,
    void Function()? onTap,
    IconData? icon,
    bool hideIcon = false,
    Color? iconColor,
    Color? btnColor,
    double? fontSize,
    Color? txtColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 50,
      width: width ?? 250,
      // width:/*width ??*/Get.width > 1500 ?250: Get.width > 1000 ?250 :Get.width > 800 ?250 :150 ,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: btnColor ?? Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          hideIcon
              ? const SizedBox()
              : Icon(icon, color: iconColor ?? Colors.white, size: 25),
          hideIcon ? const SizedBox() : const SizedBox(width: 5),
          Text(
            "$title",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: txtColor ?? Colors.black,
                fontSize: fontSize ?? 20),
          ),
        ],
      )),
    ),
  );
}

commonIconButtonMedium(
    {EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    String? title,
    void Function()? onTap,
    double? fontSize,
    IconData? icon,
    Color? btnColor,
    Color? iconColor,
    Color? txtColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 45,
      width: width ?? 175,
      // width:/*width ??*/Get.width > 1500 ?250: Get.width > 1000 ?250 :Get.width > 800 ?250 :150 ,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: btnColor ?? Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? Colors.white, size: 20),
          const SizedBox(width: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "$title",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: txtColor ?? Colors.black,
                  fontSize: fontSize ?? 15),
            ),
          ),
        ],
      )),
    ),
  );
}

commonIconButtonSmall(
    {EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    String? title,
    Function()? onTap,
    double? fontSize,
    IconData? icon,
    Color? iconColor,
    Color? btnColor,
    Color? txtColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 40,
      width: width ?? 150,
      // width:/*width ??*/Get.width > 1500 ?250: Get.width > 1000 ?250 :Get.width > 800 ?250 :150 ,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: btnColor ?? Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(7)),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? Colors.white, size: 20),
          const SizedBox(width: 2),
          FittedBox(
            // fit: BoxFit.scaleDown,
            child: Text(
              "$title",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: txtColor ?? Colors.black,
                  fontSize: fontSize ?? 10),
            ),
          ),
        ],
      )),
    ),
  );
}

commonButton(
    {EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    String? title,
    void Function()? onTap,
    IconData? icon,
    Color? btnColor,
    double? fontSize,
    Color? txtColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 50,
      width: width ?? 250,
      // width:/*width ??*/Get.width > 1500 ?250: Get.width > 1000 ?250 :Get.width > 800 ?250 :150 ,
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: btnColor ?? Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
          child: Text(
        "$title",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: txtColor ?? Colors.black,
            fontSize: fontSize ?? 20),
      )),
    ),
  );
}

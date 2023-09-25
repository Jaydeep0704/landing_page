import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';

class CommonDropDown extends StatelessWidget {
  // final String? title;
  final List<String>? itemList;
  final String? dropDownValue;
  final String? validationMessage;
  final String? hintText;
  final double? topPadding;
  final Color? fillColor;
  final bool isTransparentColor;
  final bool needValidation;
  final String? Function(String?)? validator;

  final void Function(String?)? onChange;

  const CommonDropDown(
      {Key? key,
      // this.title,
      this.itemList,
      this.dropDownValue,
      this.onChange,
      this.validator,
      this.validationMessage,
      this.topPadding,
      this.hintText,
      this.fillColor,
      this.isTransparentColor = false,
      this.needValidation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: AppTextStyle.regular400.copyWith(fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor,
        hintText: hintText,
        hintStyle: AppTextStyle.regular400
            .copyWith(color: AppColors.blackColor, fontSize: 15),
        contentPadding:
            const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: isTransparentColor
                    ? AppColors.transparentColor
                    : AppColors.blackColor),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isTransparentColor
                    ? AppColors.transparentColor
                    : AppColors.blackColor),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isTransparentColor
                    ? AppColors.transparentColor
                    : AppColors.blackColor),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isTransparentColor
                    ? AppColors.transparentColor
                    : AppColors.blackColor),
            borderRadius: BorderRadius.circular(10)),
      ),
      validator: needValidation == true
          ? (v) {
              if (v == null) {
                return "$validationMessage is required";
              }
              return null;
            }
          : null,
      isDense: true,
      onChanged: onChange,
      value: dropDownValue,
      items: itemList!.map((selectedType) {
        return DropdownMenuItem(
          value: selectedType,
          child: Text(
            selectedType,
            style: const TextStyle(fontSize: 15, fontFamily: "Poppins"),
          ),
        );
      }).toList(),
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.greyColor,
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, String>> dropdownItems = [
    {
      "case_study_type": "AI",
      "value": "AI",
    },
    {
      "case_study_type": "Science",
      "value": "Science",
    },
    {
      "case_study_type": "Marketing",
      "value": "Marketing",
    },
    {
      "case_study_type": "Finance",
      "value": "Finance",
    },
  ];

  Map<String, String>? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dropdown Example'),
        ),
        body: Center(
          child: DropdownButton<Map<String, String>>(
            hint: const Text('Select an item'),
            value: selectedValue,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: dropdownItems.map<DropdownMenuItem<Map<String, String>>>(
                (Map<String, String> item) {
              return DropdownMenuItem<Map<String, String>>(
                value: item,
                child: Text("${item['case_study_type']} - ${item['value']}"),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

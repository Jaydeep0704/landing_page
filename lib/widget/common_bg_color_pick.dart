// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickDialog extends StatefulWidget {
  Color? containerColor;
  // String? containerColor;
  String? keyNameClr;
  String? keyNameImg;
  String? switchKeyNameImg;
  String? switchKeyNameClr;
  String? clrSwitchValue;
  String? imgSwitchValue;
  bool isTextBGColorEdit;
  ColorPickDialog({
    Key? key,
    this.containerColor,
    this.isTextBGColorEdit = false,
    this.keyNameClr,
    this.keyNameImg,
    this.switchKeyNameImg,
    this.clrSwitchValue,
    this.imgSwitchValue,
    this.switchKeyNameClr,
  }) : super(key: key);

  @override
  State<ColorPickDialog> createState() => _ColorPickDialogState();
}

class _ColorPickDialogState extends State<ColorPickDialog> {
  EditController editController = Get.find<EditController>();

  void changeColor(Color color) {
    log("color is ---------- $color");
    setState(() {
      widget.containerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: widget.containerColor!,
          // pickerColor: Color(int.parse(widget.containerColor!.toString())),
          onColorChanged: changeColor,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            editController.saveBgColorToApi(
              context: context,
              color: widget.containerColor!,
              keyNameClr: widget.keyNameClr,
              clrSwitchValue: widget.clrSwitchValue,
              imgSwitchValue: widget.imgSwitchValue,
              keyNameImg: widget.keyNameImg,
              switchKeyNameClr: widget.switchKeyNameClr,
              switchKeyNameImg: widget.switchKeyNameImg,
              isTextBGColorEdit: widget.isTextBGColorEdit,
            );

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

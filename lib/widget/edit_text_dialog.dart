// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/intro_section_controller.dart';


class TextEditModule extends StatefulWidget {
  String? textValue;
  String? textKeyName;
  String? colorKeyName;
  String? fontFamily;
  String? fontFamilyKeyName;
  String? fontSize;
  // var currentColor;
  Color? textColor;
  bool? showTextField;

  TextEditModule({Key? key,this.textValue,this.textKeyName,this.showTextField = true,this.colorKeyName,
    this.textColor,
    /*this.currentColor,*/this.fontFamily = "Roboto",this.fontFamilyKeyName,this.fontSize,}) : super(key: key);

  @override
  State<TextEditModule> createState() => _TextEditModuleState();
}

class _TextEditModuleState extends State<TextEditModule> {
  final introSecController = Get.find<IntroSectionController>();
  final editController = Get.find<EditController>();
  final txtController = TextEditingController();
  Color pickerColor = const Color(0xff443A49);
  TextEditingController hexInputController = TextEditingController();
  String selectedFont = "Roboto";
  TextStyle? selectedFontTextStyle;
  final List<String> myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Cousine",
    "Croissant One",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Josefin Slab",
    "Lato",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Source Sans Pro",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab",
  ];



  void changeColor(Color color) {
    log("color is ---------- $color");
    setState(() {
      widget.textColor = color;
      // Color(int.parse(widget.containerColor!.toString())) = color;
      // widget.containerColor!.toString() = color.value.toString();
    });
  }
  // // ValueChanged<Color> callback
//   void changeColor(Color color) {
//     setState(() => pickerColor = color);
//   }

  @override
  void initState() {
    super.initState();
    log("-==-=-=-=-=-=------ : ${widget.textValue.toString()}");
    if(widget.textValue.toString() != null){
      txtController.text = widget.textValue!;
    }
    // pickerColor = widget.currentColor;
  }
  @override
  Widget build(BuildContext context) {
    // debugPrint("widget.currentColor   ${widget.currentColor}");
    return AlertDialog(
      title: Text(
        "Update Text Dialog",
        textAlign: TextAlign.center,
        style: AppTextStyle.regularBold.copyWith(color: Colors.black,fontSize: 25),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update String",
              style: AppTextStyle.regularBold.copyWith(color: Colors.black,fontSize: 20),
            ),
            const SizedBox(height: 15),
            if(widget.showTextField == true)TextFormField(
              controller: txtController,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Text(
              "Font Color Styling",
              style: AppTextStyle.regularBold.copyWith(color: Colors.black,fontSize: 20),
            ),
            const SizedBox(height: 15),
            ColorPicker(
              // hexInputBar: true,
              // hexInputController: hexInputController,
              // pickerColor: pickerColor,
              pickerColor:  widget.textColor ??const Color(0xff000000),
              onColorChanged: changeColor,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Font Type styling",
                style: AppTextStyle.regularBold.copyWith(color: Colors.black,fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Select Font'),
              onPressed: () => fontDialog(),
            ),
          ],
        ),
      ),

      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            editController.editText(
              context: context,
              color: widget.textColor,
              colorKeyName: widget.colorKeyName,
             text:txtController.text.isNotEmpty ?txtController.text : "",
             textKeyName: widget.textKeyName.toString().isNotEmpty ?widget.textKeyName:"",
              fontFamily: widget.fontFamily,
              fontFamilyKeyName: widget.fontFamilyKeyName,
            );
            // setState(() {
            //   // widget.currentColor = pickerColor;
            //   log("pickerColor ------------>   $pickerColor");
            //   // introSecController.introMainTitleColor.value = pickerColor;
            //   introSecController.introMainTitle.value = txtController.text ;
            // });
            // fontDialog();
            Get.back();
            txtController.clear();
          },
        ),
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {Get.back();
          txtController.clear();},
        ),
      ],
    );
  }
  fontDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: FontPicker(
                showInDialog: true,
                initialFontFamily: 'Anton',
                onFontChanged: (font) {
                  setState(() {
                    selectedFont = font.fontFamily;
                    widget.fontFamily = font.fontFamily;
                    selectedFontTextStyle = font.toTextStyle();
                  });
                  debugPrint("${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                  );
                },
                googleFonts: myGoogleFonts,
              ),
            ),
          ),
        );
      },
    );
  }

}

String selectedFont = "Roboto";
TextStyle? selectedFontTextStyle;
final List<String> myGoogleFonts = [
  "Abril Fatface",
  "Aclonica",
  "Alegreya Sans",
  "Architects Daughter",
  "Archivo",
  "Archivo Narrow",
  "Bebas Neue",
  "Bitter",
  "Bree Serif",
  "Bungee",
  "Cabin",
  "Cairo",
  "Coda",
  "Comfortaa",
  "Comic Neue",
  "Cousine",
  "Croissant One",
  "Faster One",
  "Forum",
  "Great Vibes",
  "Heebo",
  "Inconsolata",
  "Josefin Slab",
  "Lato",
  "Libre Baskerville",
  "Lobster",
  "Lora",
  "Merriweather",
  "Montserrat",
  "Mukta",
  "Nunito",
  "Offside",
  "Open Sans",
  "Oswald",
  "Overlock",
  "Pacifico",
  "Playfair Display",
  "Poppins",
  "Raleway",
  "Roboto",
  "Roboto Mono",
  "Source Sans Pro",
  "Space Mono",
  "Spicy Rice",
  "Squada One",
  "Sue Ellen Francisco",
  "Trade Winds",
  "Ubuntu",
  "Varela",
  "Vollkorn",
  "Work Sans",
  "Zilla Slab",
];

//  const Icon(
//                                                   Icons.font_download,
//                                                   color: Colors.blue,
//                                                   size: 30,
//                                                 ),
///

//    appHeaderStyle = GoogleFonts.getFont(appHeaderFont).copyWith(
//         fontSize: appFontSize,
//         fontWeight: FontWeight.normal,
//         color: appHeaderColor);
///
//  void updateAppHeaderTextStyle(PickerFont font) {
//     setState(() {
//       appHeaderFont = font.fontFamily;
//     });
//   }
///
//   void updateAppHeaderColor(Color color) {
//     if (mounted) {
//       setState(() {
//         appHeaderColor = color;
//       });
//       Navigator.pop(context);
//     }
//   }
///
//  appHeaderFontChooser() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               content: SingleChildScrollView(
//                 child: SizedBox(
//                   width: double.maxFinite,
//                   child: FontPicker(
//                     showInDialog: true,
//                     onFontChanged: (font) {
//                       updateAppHeaderTextStyle(font);
//                     },
//                     //  googleFonts: _myGoogleFonts
//                   ),
//                 ),
//               ));
//         });
//   }
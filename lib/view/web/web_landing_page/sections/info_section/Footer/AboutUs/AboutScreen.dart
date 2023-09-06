import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/getwidget.dart';
import '../helpController.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {



  final helpController = Get.find<HelpController>();

  @override
  void initState() {
    super.initState();
    helpController.getAboutUs();

  }


  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:   AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Aobut Us", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back, color:  Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body:Container(
        padding: Get.width > 1500
            ? const EdgeInsets.only(left: 100, right: 300)
            : Get.width > 1000
            ? const EdgeInsets.only(left: 100, right: 150)
            : Get.width > 500
            ? const EdgeInsets.only(left: 10, right: 10)
            : const EdgeInsets.only(left: 10, right: 10),
        child:

        FutureBuilder<bool>(
          future: helpController.getAboutUs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {

              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: const GFLoader(
                  type: GFLoaderType.circle,
                ),
              );
            } else {

              if (snapshot.hasError) {
                return Text('Error occurred while fetching data.');
              } else {

                if (snapshot.data == true) {

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Html(data: helpController.aboutus),
                        ),
                      ],
                    ),
                  );
                } else {

                  return Text('Error occurred while fetching data.');
                }
              }
            }
          },
        ),
      ),
    );



  }

}
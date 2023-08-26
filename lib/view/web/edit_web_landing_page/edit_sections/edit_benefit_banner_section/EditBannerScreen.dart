
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

import 'edit_banner_controller.dart';

class EditBanerScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  EditBanerScreen({Key? key,required this.id,required this.title,required this.description}) : super(key: key);
  @override
  State<EditBanerScreen> createState() => _EditBanerScreenState();
}

class _EditBanerScreenState extends State<EditBanerScreen> {
  final benefitBannerController = Get.find<BenefitBannerController>();
  TextEditingController description_controller = TextEditingController();
  TextEditingController tile_controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("id=====>");
    debugPrint(widget.id);
    description_controller.text=widget.description;
    tile_controller.text=widget.title;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      benefitBannerController.getDataApi();
    });
  }
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Update Text",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(
                  children:[
                    Expanded(
                        child:
                        SizedBox()
                    ),
                    SizedBox(
                      width: Get.width > 800 ? 700 :400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text("Enter text and description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                            SizedBox(height: 10,),

                            const Text("Enter Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

                            SizedBox(height: 10,),

                            TextFormField(
                              controller: tile_controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                  const EdgeInsets.all(
                                      10),
                                  hintText: "Enter Title",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  )
                              ),
                            ),

                            SizedBox(height: 20,),

                            const Text("Enter Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

                            SizedBox(height: 10,),

                            TextFormField(
                                controller: description_controller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(
                                        10, 15, 0, 0),
                                    hintText:
                                    'Enter  Description',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    )
                                ),
                                maxLines: 5,
                                keyboardType: TextInputType.text
                            ),

                            SizedBox(height: 10,),

                            Container(
                              padding: EdgeInsets.all(16),
                              color: Colors.white,
                              child:  InkWell(
                                onTap: () async {
                                  if(validation()==true){
                                    benefitBannerController.updateDataApi(id:widget.id ,
                                        title: tile_controller.text,
                                        description: description_controller.text);
                                  }

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent,
                                  ),
                                  height: 40,
                                  padding: EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                    Expanded(
                        child:
                        SizedBox()
                    ),
                  ]

              ),
            ),
          ),
        );
      },

    );

  }


  bool validation(){
    if(tile_controller.text.isEmpty ||tile_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Title' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }else if(description_controller.text.isEmpty ||description_controller.text=="" ){
      Fluttertoast.showToast(
        msg:  'Please Enter Description' ,
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }


}

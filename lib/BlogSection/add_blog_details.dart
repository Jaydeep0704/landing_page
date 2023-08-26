
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

import 'package:video_player/video_player.dart';
import '../../../config/api_string.dart';
import 'dart:html' as html;
import '../../../widget/common_snackbar.dart';
import '../../../widget/loading_dialog.dart';

import 'package:http/http.dart' as http;

import 'blog_controller.dart';

class add_blog_details extends StatefulWidget {
  final String id;
  add_blog_details({Key? key,required this.id}) : super(key: key);
  @override
  State<add_blog_details> createState() => _add_blog_detailsState();
}

class _add_blog_detailsState extends State<add_blog_details> {
  final blog_controller = Get.find<EditBlogController>();
  TextEditingController description_controller = TextEditingController();
  TextEditingController tile_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Add Blog Details",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(
                  children:[
                    const Expanded(
                        child:
                        SizedBox()
                    ),
                    SizedBox(
                      width: Get.width > 800 ? 500 :300,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            const SizedBox(height: 20,),
                            const Text("Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

                            const SizedBox(height: 10,),

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

                            const SizedBox(height: 20,),

                            const Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

                            const SizedBox(height: 10,),

                            TextFormField(
                                controller: description_controller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(
                                        10, 15, 0, 0),
                                    hintText:
                                    'Enter Description',
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


                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.white,
                              child:  InkWell(
                                onTap: () async {
                                  if(validation()==true){
                                    blog_controller.add_blog_details_api(id:widget.id,
                                        title: tile_controller.text,
                                        description: description_controller.text
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent,
                                  ),
                                  height: 40,
                                  padding: const EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Add",
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
                    const Expanded(
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

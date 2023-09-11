import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CSTypeCrudScreen extends StatefulWidget {
  bool? isEdit;
  CSTypeCrudScreen({super.key,this.isEdit = false});

  @override
  State<CSTypeCrudScreen> createState() => _CSTypeCrudScreenState();
}

class _CSTypeCrudScreenState extends State<CSTypeCrudScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text( widget.isEdit!  ?"Edit Case Type Category":"Add Case Type Category",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          //blogTypeKey,media,media_type,blogs_section_color
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Row(children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: Get.width > 800 ? 500 : 300,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      ],
                  ),
                ),
                const Expanded(child: SizedBox()),
              ]),
            ),
          ),
        );
      },
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'edit_banner_controller.dart';

class EditBanerScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  const EditBanerScreen(
      {Key? key,
      required this.id,
      required this.title,
      required this.description})
      : super(key: key);
  @override
  State<EditBanerScreen> createState() => _EditBanerScreenState();
}

class _EditBanerScreenState extends State<EditBanerScreen> {
  final benefitBannerController = Get.find<BenefitBannerController>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tileController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("id=====>");
    debugPrint(widget.id);
    descriptionController.text = widget.description;
    tileController.text = widget.title;
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
            title: const Text("Update Text",
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
              child: Row(children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: Get.width > 800 ? 700 : 400,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                            child: Text(
                          "Enter text and description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: tileController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Enter Title",
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Enter Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                hintText: 'Enter  Description',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            maxLines: 5,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              if (validation() == true) {
                                benefitBannerController.updateDataApi(
                                    id: widget.id,
                                    title: tileController.text,
                                    description: descriptionController.text);
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
                                "Update",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
                const Expanded(child: SizedBox()),
              ]),
            ),
          ),
        );
      },
    );
  }

  bool validation() {
    if (tileController.text.isEmpty || tileController.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Title',
        backgroundColor: Colors.grey,
      );
      return false;
    } else if (descriptionController.text.isEmpty ||
        descriptionController.text == "") {
      Fluttertoast.showToast(
        msg: 'Please Enter Description',
        backgroundColor: Colors.grey,
      );
      return false;
    }
    return true;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/TandC/termsCondition.dart';

class AddressSection extends StatefulWidget {
  const AddressSection({Key? key}) : super(key: key);

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {

  // final getbanner = Get.find<banner_controller>();
  final editInfoController = Get.find<EditInfoController>();
  final editController = Get.find<EditController>();
  final webLandingPageController = Get.find<WebLandingPageController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   editInfoController.getImages();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.addressSection.value == false || editController.allDataResponse.isEmpty
              ? const SizedBox()
              : Container(
            width: Get.width,
            decoration:
            BoxDecoration(color: Colors.grey[200]),
            child: Column(
              children: [
                SizedBox(height: Get.width > 1000 ? 60 : 30),
                // Get.width > 1000 ? horizontalInfo() : verticalInfo(),
                Get.width > 1000 ? horizontalInfo() : verticalInfo(),
                SizedBox(height: Get.width > 1000 ? 60 : 30),
              ],
            ),
          );
        });
      },
    );
  }

  ///Address section - vertical
  verticalInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 450,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        const TextSpan(
                          // text: 'GroBiz\u00AE',
                          text: 'GroBiz',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0, -8),
                            child: const Text(
                              '®',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: ' 2nd Floor, Sr No 135/6, Kalamkar Premises, Near Rasta Cafe, Baner, Balewadi Phata, Pune Pune MH 411045 IN ',
                        ),
                        const TextSpan(
                          text: 'Copyright © 2020-2023 Geobull Innovation. All rights reserved.',
                        ),
                      ],
                    ),

                  ),
                ),
                Row(

                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => TnCScreen())!.whenComplete(() => Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                      },
                      child: const Text(
                        'T&C',
                        style: TextStyle(fontSize: 18, color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),


                    const SizedBox(width: 10,),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 20,
                      width: 1.5,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Get.to(() => PrivacyPolicy())!.whenComplete(() =>     Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                      },
                      child: const Text(
                        'Privacy',
                        style: TextStyle(fontSize: 18, color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            if (editInfoController.imagesList.isNotEmpty) {
              return
                Container(
                    height: 90,
                    padding: const EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.only(left: 15, right: 0, bottom: 5),
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: editInfoController.imagesList.length,
                      itemBuilder: (context, index) {
                        var data = editInfoController.imagesList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            height: 90,width: 90,
                            imageUrl: APIString.latestmediaBaseUrl +
                                data["images"].toString(),
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    )
                );
            } else {
              return const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'No Data ..',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  ///Address section - horizontal
  horizontalInfo() {
    // debugPrint("Banner List length: ${getbanner.bannerList.length}");
    // debugPrint("Is Banner List empty? ${getbanner.bannerList.isEmpty}");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 100.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                SizedBox(
                  width: 450,
                  child:
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'GroBiz',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0, -8),
                            child: const Text(
                              '®',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // TextSpan(
                        //   text: '®',
                        //   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                        // ),
                        const TextSpan(
                          text:
                          ' ,2nd Floor, Sr No 135/6, Kalamkar Premises, Near Rasta Cafe, Baner, Balewadi Phata,  Pune MH 411045 IN.',
                        ),

                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children:  [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [   const Text(
                //         'GroBiz',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           decoration: TextDecoration.underline,
                //         ),
                //       ),
                //         const Text(
                //           '®',
                //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                //         ),],
                //     ),
                //
                //     const Expanded(
                //       child: Text(
                //         ' ,2nd Floor, Sr No 135/6, Kalamkar Premises, Near Rasta Cafe, Baner, Balewadi Phata,  Pune MH 411045 IN.',
                //       ),
                //     ),
                //   ],
                // ),
                const Text("Copyright © 2020-2023 Geobull Innovation. All rights reserved.", style: TextStyle(fontSize: 18, color: Colors.black),),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => TnCScreen())!.whenComplete(() =>     Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                      },
                      child: const Text(
                        'T&C',
                        style: TextStyle(fontSize: 18, color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 20,
                      width: 1.5,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Get.to(() => PrivacyPolicy())!.whenComplete(() =>     Future.delayed(Duration.zero,(){webLandingPageController.getUserCount();}));
                      },
                      child: const Text(
                        'Privacy',
                        style: TextStyle(fontSize: 18, color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (editInfoController.imagesList.isNotEmpty) {
            return
              Container(
                alignment: Alignment.centerRight,
                  height: 130,
                  width: 735,
                  padding: const EdgeInsets.only(top: 5),
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child:
                  ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: editInfoController.imagesList.length,
                    itemBuilder: (context, index) {
                      var data = editInfoController.imagesList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: APIString.latestmediaBaseUrl +
                              data["images"].toString(),
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  )
              );
          }
          else {
            return const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'No Data ..',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}

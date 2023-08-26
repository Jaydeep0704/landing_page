import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';

class EditFifteenthSection extends StatefulWidget {
  const EditFifteenthSection({Key? key}) : super(key: key);

  @override
  State<EditFifteenthSection> createState() => _EditFifteenthSectionState();
}

class _EditFifteenthSectionState extends State<EditFifteenthSection> {
  final landingPageController = Get.find<WebLandingPageController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.bgPink.withOpacity(0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              mobileViewTut(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: Get.width * 0.8,
              //       child: Stack(
              //         children: [
              //         Get.width< 600 ? const SizedBox():  Container(
              //             height: 350,
              //             // width: 250,
              //             width: Get.width * 0.3,
              //             // margin: const EdgeInsets.only(right: 400),
              //             decoration: BoxDecoration(
              //                 color: AppColors.greyBorderColor,
              //                 border: Border.all(
              //                     color: AppColors.whiteColor, width: 0.8),
              //                 borderRadius:
              //                     const BorderRadius.all(Radius.circular(15))),
              //           ),
              //           Positioned(
              //             right: 10,
              //             child: Container(
              //               height: 400,
              //               width: Get.width * 0.7,
              //               // width: 300,
              //               decoration: const BoxDecoration(
              //                   color: AppColors.whiteColor,
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(15))),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 25),
              //     btnColumn(),
              //   ],
              // ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  btnColumn() {
    return Column(
      children: [
        Obx(() {
          return landingPageController.selectedMobileDevice.value == true
              ? InkWell(
            onTap: () {
              landingPageController.selectedMobileDevice.value = true;
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(colors: [
                    AppColors.greenColor.withOpacity(0.7),
                    AppColors.blueColor.withOpacity(0.7)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight
                    // radius: 0.75,
                  ),
                ),
                child: const Center(child: Icon(Icons.phone_android))),
          )
              : InkWell(
            onTap: () {
              landingPageController.selectedMobileDevice.value = true;
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(25)),
                    color: AppColors.blackColor,
                    border: Border.all(
                        color: AppColors.whiteColor.withOpacity(0.5))),
                child: const Center(
                    child: Icon(
                      Icons.phone_android,
                      color: AppColors.whiteColor,
                    ))),
          );
        }),
        const SizedBox(height: 20),
        Obx(() {
          return landingPageController.selectedMobileDevice.value == false
              ? InkWell(
            onTap: () {
              landingPageController.selectedMobileDevice.value = false;
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(colors: [
                    AppColors.greenColor.withOpacity(0.7),
                    AppColors.blueColor.withOpacity(0.7)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight
                    // radius: 0.75,
                  ),
                ),
                child: const Center(
                    child: Icon(Icons.desktop_windows_outlined))),
          )
              : InkWell(
            onTap: () {
              landingPageController.selectedMobileDevice.value = false;
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(25)),
                  color: AppColors.blackColor,
                  border: Border.all(color: AppColors.whiteColor)),
              child: Center(
                child: Icon(
                  Icons.desktop_windows_outlined,
                  color: AppColors.whiteColor.withOpacity(0.5),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
  mobileViewTut(){
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:  700,
          child: Stack(
            children: [
              Get.width< 600 ? const SizedBox()
                  :  Positioned(
                right: 0,left: 0,
                child: Container(
                  height: 600,
                  // width: 250,
                  width: 350,
                  // margin: const EdgeInsets.only(right: 400),
                  decoration: BoxDecoration(
                      color: AppColors.greyBorderColor,
                      border: Border.all(
                          color: AppColors.whiteColor, width: 0.8),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(height: 2),
                      Text("Information Page"),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                // right: 10,
                child: Container(
                  height: 600,
                  width: Get.width > 1500 ? 350: 350,
                  // width: 300,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))),
                  child: const Center(child:Text("media"),),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        btnColumn(),
      ],
    );
  }
  webViewTut(){
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.8,
          child: Stack(
            children: [
              Get.width< 600 ? const SizedBox():  Container(
                height: 350,
                // width: 250,
                width: Get.width * 0.3,
                // margin: const EdgeInsets.only(right: 400),
                decoration: BoxDecoration(
                    color: AppColors.greyBorderColor,
                    border: Border.all(
                        color: AppColors.whiteColor, width: 0.8),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(15))),
              ),
              Positioned(
                right: 10,
                child: Container(
                  height: 400,
                  width: Get.width * 0.7,
                  // width: 300,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        btnColumn(),
      ],
    );
  }
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/image_path.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog({bool? loadingText=false,bool? loader = true,bool? delay = false}) {
  Future.delayed(
    delay == false ?Duration.zero : const Duration(seconds: 1),
        () {
      Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Material(
            color: Colors.transparent,
            // color: AppColors.whiteColor.withOpacity(0.8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: loader == true && loadingText == false ?Colors.transparent:AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: Image.asset(ImagePath.appLogo,height: 100,width: 100,),
                        // ),
                        loader == false ?const SizedBox(): Center(
                            child : Lottie.asset('assets/loader_lottie.json',height: 100,width: 100)
                        ),
                        // loader == false ?const SizedBox(): const CircularProgressIndicator(),
                        loadingText == false ?const SizedBox(): const Text("Please wait file is loading"),
                      ],
                    ),
                  )
              ),
            ),
          ),
        ),
      );
    },
  );
}

void hideLoadingDialog({bool isTrue = false}) {
  Get.back(
    closeOverlays: isTrue,
  );
}





//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grobiz_web_landing/config/app_colors.dart';
// import 'package:grobiz_web_landing/config/image_path.dart';
//
// void showLoadingDialog({bool? loadingText=false,bool? loader = true,bool? delay = false}) {
//   Future.delayed(
//     delay == false ?Duration.zero : const Duration(seconds: 1),
//         () {
//       Get.dialog(
//         barrierDismissible: false,
//           WillPopScope(
//             onWillPop: () async{
//               return false;
//             },
//             child: Material(
//               // color: Colors.transparent,
//               color: AppColors.whiteColor.withOpacity(0.8),
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: loader == true && loadingText == false ?Colors.transparent:AppColors.whiteColor,
//                       borderRadius: BorderRadius.circular(10)),
//                   child : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Image.asset(ImagePath.appLogo,height: 100,width: 100,),
//                         ),
//
//                         loader == false ?const SizedBox(): const CircularProgressIndicator(),
//                         loadingText == false ?const SizedBox(): const Text("Please wait file is loading"),
//                       ],
//                     ),
//                   )
//                 ),
//               ),
//             ),
//           ),
//           );
//     },
//   );
// }
//
// void hideLoadingDialog({bool isTrue = false}) {
//   Get.back(
//     closeOverlays: isTrue,
//   );
// }


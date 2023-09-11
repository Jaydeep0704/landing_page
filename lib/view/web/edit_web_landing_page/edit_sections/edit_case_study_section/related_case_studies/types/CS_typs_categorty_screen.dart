import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/text_style.dart';

//CSTypeCrudScreen
//CS_typs_add_update_screen
class CSTypeCategoryScreen extends StatefulWidget {
  const CSTypeCategoryScreen({super.key});

  @override
  State<CSTypeCategoryScreen> createState() => _CSTypeCategoryScreenState();
}

class _CSTypeCategoryScreenState extends State<CSTypeCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(
          color: AppColors.blackColor,
        ),
        title: Text(
            "Case Study Categories",
            style: AppTextStyle.regularBold.copyWith(color: AppColors.blackColor, fontSize: 18)),
        centerTitle: true,
      ),
      body: Row(
        children: [
          const Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor, boxShadow: [
              BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 3)
            ]),
            width: Get.width > 800 ? 700 : Get.width,
            child: Column(
              children: [
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>const Scaffold())!.whenComplete(() {});
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.5),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              children: const [
                                Icon(Icons.add),
                                SizedBox(width: 3),
                                Text("Case Study Categories")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Case Study Type",style: AppTextStyle.regular600,),
                          const SizedBox(height: 10),
                          Text("Artificial intelligence",style: AppTextStyle.regular300.copyWith(color: AppColors.greyBorderColor),),
                          const SizedBox(height: 20),
                          Text("Case Study Type Key",style: AppTextStyle.regular600,),
                          const SizedBox(height: 10),
                          Text("AI",style: AppTextStyle.regular300.copyWith(color: AppColors.greyBorderColor),),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

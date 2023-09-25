// ignore_for_file: file_names

import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'AddBanerScreen.dart';
import 'EditBannerScreen.dart';
import 'edit_banner_controller.dart';

class EditBanerList extends StatefulWidget {
  const EditBanerList({Key? key}) : super(key: key);

  @override
  State<EditBanerList> createState() => _EditBanerListState();
}

class _EditBanerListState extends State<EditBanerList> {
  final benefitBannerController = Get.find<BenefitBannerController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      benefitBannerController.getDataApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: const BackButton(
            color: AppColors.blackColor,
          ),
          title: Text("Edit Text",
              style: AppTextStyle.regularBold
                  .copyWith(color: AppColors.blackColor, fontSize: 18)),
          centerTitle: true,
        ),
        body: Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              decoration:
                  BoxDecoration(color: AppColors.whiteColor, boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.0),
                    blurRadius: 1,
                    spreadRadius: 2)
              ]),
              width: Get.width > 800 ? 700 : 400,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddBanerScreen()));
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
                              Text("Add New Text")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Note : Please add only 3 data for better view",
                        style: AppTextStyle.regularBold
                            .copyWith(fontSize: 14, color: AppColors.redColor),
                        textAlign: TextAlign.end,
                      )),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Obx(() {
                      if (benefitBannerController.dataList.isNotEmpty) {
                        return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  benefitBannerController.dataList.length,
                              itemBuilder: (context, index) {
                                var data =
                                    benefitBannerController.dataList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              data["title"].toString(),
                                              style: AppTextStyle.regularBold
                                                  .copyWith(fontSize: 20),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditBanerScreen(
                                                    id: data["_id"].toString(),
                                                    title: data["title"]
                                                        .toString(),
                                                    description:
                                                        data["description"]
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              data["description"].toString(),
                                              style: AppTextStyle.regular300
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              benefitBannerController
                                                  .deleteDataApi(
                                                      id: data["_id"]
                                                          .toString());
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 0.8,
                                        color: AppColors.blackColor
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ));
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
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }
}

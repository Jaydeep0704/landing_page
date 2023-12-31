import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/config/text_style.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/pricing_section/pricing_section.dart';
import 'package:grobiz_web_landing/widget/common_bg_color_pick.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/widget/common_bg_img_pick.dart';
import 'package:grobiz_web_landing/widget/edit_text_dialog.dart';
import 'package:url_launcher/url_launcher.dart';


class EditPricingSection extends StatefulWidget {
  const EditPricingSection({Key? key}) : super(key: key);

  @override
  State<EditPricingSection> createState() => _EditPricingSectionState();
}

class _EditPricingSectionState extends State<EditPricingSection> {
  final editController = Get.find<EditController>();
  final pricingScreenController = Get.find<PricingScreenController>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          return editController.homeComponentList.isEmpty /*&&*/ || editController.allDataResponse.isEmpty ? const SizedBox() :
          Container(

            width: Get.width,
            decoration: editController
                .allDataResponse[0]["pricing_details"][0] ["pricing_bg_color_switch"]
                .toString() == "1" &&
                editController
                    .allDataResponse[0]["pricing_details"][0]["pricing_bg_image_switch"]
                    .toString() == "0"
                ? BoxDecoration(
              color: editController
                  .allDataResponse[0]["pricing_details"][0]["pricing_bg_color"]
                  .toString()
                  .isEmpty
                  ? Color(
                  int.parse(editController.pricingBgColor.value.toString()))
                  : Color(int.parse(editController
                  .allDataResponse[0]["pricing_details"][0]["pricing_bg_color"]
                  .toString())),
            )
                : BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(
                  APIString.mediaBaseUrl +
                      editController.allDataResponse[0]["pricing_details"]
                      [0]["pricing_bg_image"]
                          .toString(),
                  errorListener: () => const Icon(Icons.error),),
                    fit: BoxFit.cover)
            ),

            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: editController.pricing
                              .value,
                          onChanged: (value) {
                            setState(() {
                              editController.pricing.value = value;
                              editController.showHideComponent(
                                  value: value == false
                                      ? "No"
                                      : "Yes",
                                  componentName: "pricing");
                            });
                          },
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () => Get.back(),
                                                icon: const Icon(Icons.close)),
                                          ), ElevatedButton(onPressed: () {
                                            Get.dialog(ColorPickDialog(
                                              containerColor: Color(int.parse(
                                                  editController
                                                      .allDataResponse[0]["pricing_details"][0]["pricing_bg_color"]
                                                      .toString())),
                                              keyNameClr: "pricing_bg_color",
                                              clrSwitchValue: "1",
                                              imgSwitchValue: "0",
                                              switchKeyNameImg: "pricing_bg_image_switch",
                                              switchKeyNameClr: "pricing_bg_color_switch",
                                            ));
                                          }, child: const Text("Color Picker")),
                                          const SizedBox(height: 20),
                                          ElevatedButton(onPressed: () {
                                            Get.dialog(ImgPickDialog(
                                              keyNameImg: "pricing_bg_image",
                                              switchKeyNameImg: "pricing_bg_image_switch",
                                              switchKeyNameClr: "pricing_bg_color_switch",
                                            ));
                                          }, child: const Text("Image Picker"))
                                        ],
                                      )
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(Icons.colorize, color: editController
                              .allDataResponse[0]["pricing_details"][0]["pricing_bg_color"]
                              .toString() != "4294967295"
                              ? AppColors.whiteColor : AppColors.blackColor),),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    // top: 42,
                      left: Get.width > 650 ? Get.width * 0.088 : Get.width *
                          0.05,
                      right: Get.width > 650 ? Get.width * 0.088 : Get.width *
                          0.05),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              left: Get.width * 0.1, right: Get.width * 0.1),
                          // child: FittedBox(
                          //   fit: BoxFit.fitWidth,
                          //   child: Text(
                          //     "Your app project. 100% transparency.",
                          //     style: AppTextStyle.regular700,
                          //   ),
                          // ),
                          child: InkWell(
                            onTap: () =>
                                Get.dialog(
                                    TextEditModule(
                                      textKeyName: "pricing_title",
                                      colorKeyName: "pricing_title_color",
                                      fontFamilyKeyName: "pricing_title_font",
                                      textValue: editController
                                          .allDataResponse[0]["pricing_details"][0]["pricing_title"]
                                          .toString(),
                                      fontFamily: editController
                                          .allDataResponse[0]["pricing_details"][0]["pricing_title_font"]
                                          .toString(),
                                      fontSize: editController
                                          .allDataResponse[0]["pricing_details"][0]["pricing_title_size"]
                                          .toString(),
                                      textColor: Color(int.parse(editController
                                          .allDataResponse[0]["pricing_details"][0]["pricing_title_color"]
                                          .toString())),
                                    )),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                editController
                                    .allDataResponse[0]["pricing_details"][0]["pricing_title"]
                                    .toString(),
                                style: GoogleFonts.getFont(editController
                                    .allDataResponse[0]["pricing_details"][0]["pricing_title_font"]
                                    .toString()).copyWith(
                                    fontSize: editController
                                        .allDataResponse[0]["pricing_details"][0]["pricing_title_size"]
                                        .toString() != ""
                                        ? double.parse(editController
                                        .allDataResponse[0]["pricing_details"][0]["pricing_title_size"]
                                        .toString())
                                        : 25,
                                    fontWeight: FontWeight.w700,
                                    color: editController
                                        .allDataResponse[0]["pricing_details"][0]["pricing_title_color"]
                                        .toString()
                                        .isEmpty
                                        ? AppColors.blackColor
                                        : Color(int.parse(editController
                                        .allDataResponse[0]["pricing_details"][0]["pricing_title_color"]
                                        .toString()))),
                              ),
                            ),
                          ),

                        ),
                      ),
                      Obx(() {
                        return pricingScreenController.isLocation.value == true
                            ? const SizedBox()
                            : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton<int>(
                              itemBuilder: (context) =>
                              [
                                // PopupMenuItem 1
                                const PopupMenuItem(
                                  value: 1,
                                  // row with 2 children
                                  child: Text(
                                    "U.S.",
                                    style: TextStyle(color: Colors.black),),
                                ),
                                // PopupMenuItem 2
                                const PopupMenuItem(
                                  value: 2,
                                  // row with two children
                                  child: Text(
                                    "India",
                                    style: TextStyle(color: Colors.black),),
                                ),
                              ],
                              offset: const Offset(0, 100),
                              color: Colors.white,
                              elevation: 2,
                              onSelected: (value) {
                                if (value == 1) {
                                  pricingScreenController.getPlansData(
                                      lat: "37.661224", long: "-100.015796");
                                } else if (value == 2) {
                                  pricingScreenController.getPlansData(
                                      lat: "21.2378888", long: "72.863352");
                                }
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: const Text("Select Country")),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Center(
                        child:
                        SizedBox(
                          // color: Colors.yellowAccent,
                          height: 750,
                          child: Obx(() {
                            return  pricingScreenController.plansList.isEmpty ?const SizedBox(): Scrollbar(
                              controller: scrollController,
                              thickness: 10,
                              // controller: ScrollController(),
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: scrollController,
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: pricingScreenController.plansList
                                    .length,
                                itemBuilder: (context, index) {
                                  return planCard(i: index,data: pricingScreenController.plansList[index]);
                                },
                              ),
                            );
                          }),
                        ),


                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  planCard({var data, int? i}) {
    return Container(
      height: Get.width > 800 ? 500 :Get.width > 600 ? 425 : 390,
      width: Get.width > 800 ? 450 : 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
      margin: const EdgeInsets.all(20),
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(data["plan_name"],
                      style: AppTextStyle.regular600,),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: AppColors.greyBorderColor,
                  margin: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 24),
                ),
                data["per_month_price"] == '0' &&
                    data["price"] != '0' &&
                    data["plan_name"] != "Enterprise"
                    ? Container(
                  padding: const EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      data["offer_percentage"] != '0' && data["price"] != '0'
                          ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          " ${data["currency"]} ${data["price"]}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                          : Container(),
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            data["price"] != '0'
                                ? Text(
                              data["currency"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                                : Container(),
                            data["price"] != '0'
                                ? Text(
                              data["final_price"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            )
                                : Text(
                              data["final_price"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            data["offer_percentage"] != '0'
                                ? Text(
                              "(${data["offer_percentage"]}% OFF)",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                      )
                    ],
                  ),
                )
                    : Container(),
                data["plan_name"] == "Enterprise"
                    ? Container(
                  padding: const EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "Pay per Feature",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                      )
                    ],
                  ),
                )
                    : Container(),
                data["per_month_price"] != '0'
                    ? Container(
                  padding: const EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      data["offer_percentage"] != '0' && data["price"] != '0'
                          ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "${data["currency"]} ${data["per_month_price"]}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                          : Container(),
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //planModel.price!='0'?
                            Text(
                              data["currency"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data["final_month_price"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              " /month",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            data["offer_percentage"] != '0'
                                ? Text(
                              "(${data["offer_percentage"]}% OFF)",
                              // '${' (' +
                              //     data["offer_percentage"]}% OFF)',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        // width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Billed annually  ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                      )
                    ],
                  ),
                )
                    : Container(),
                data["price"] != '0' && data["plan_name"] != "Enterprise"
                    ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  // width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Validity",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      data["validity_unit"] == "Lifetime"
                          ? Text(
                        data["validity_unit"],
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )
                          : Text(
                        data["validity"] + ' ' + data["validity_unit"],
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                      )
                    ],
                  ),
                )
                    : Container(),
                const Text(
                  'Features',
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: data["features"].length,
                        itemBuilder: (context, index) =>
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: AppColors.darkPurpleColor, size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      data["features"][index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                const Divider(color: Colors.grey),
                pricingScreenController.plansSHowHidBoolList[i!] == false
                    ? GestureDetector(
                  onTap: () =>
                  {
                    changeVisibility(i),
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all(
                        color: AppColors.lightBlueColor, width: 2)),

                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 16, bottom: 12),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("View Details",
                      style: AppTextStyle.regular500.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor),),
                  ),
                )
                    : Container(),

                Visibility(
                  // visible: planModel.showDetails,
                  visible: pricingScreenController.plansSHowHidBoolList[i] == true
                      ? true
                      : false,
                  child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Plan Description',
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: data["description"].length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: AppColors.darkPurpleColor, size: 18),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        data["description"][index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },),
                        ],
                      )),
                ),
                pricingScreenController.plansSHowHidBoolList[i] == true
                    ? GestureDetector(
                  onTap: () =>
                  {
                    changeVisibility(i),
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all(
                        color: AppColors.lightBlueColor, width: 2)),
                    // color: AppColors.greenColor,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 16, bottom: 12),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("Hide Details",
                      style: AppTextStyle.regular500.copyWith(
                          fontSize: 14,
                          color: AppColors.blackColor),),
                  ),
                )
                    : Container(),
                const SizedBox(height: 40),

              ],
            ),
          ),
          Positioned(
            left: 0,right: 0,
            bottom: 0,
            // alignment: AlignmentDirectional.bottomCenter,
            child: data["plan_name"] == "Enterprise"
                ? GestureDetector(
              onTap: () {
                //openwhatsapp();
                Get.dialog(purchaseDialog(isPurchaseButton: false));
              },
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                color: AppColors.lightBlueColor,
                margin: const EdgeInsets.only(
                    left: 8, right: 8, top: 16),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text("CONNECT US",
                  style: AppTextStyle.regular500.copyWith(
                      fontSize: 14,
                      color: AppColors.whiteColor),),
              ),
            )
                : GestureDetector(
              onTap: () {
                // goToPuchasePlan(planModel);
                // Get.dialog(purchaseDialog(isPurchaseButton: true));
                redirectFreeTrial(redirectTo: data["redirect_to"]);
              },
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                color: AppColors.lightBlueColor,
                margin: const EdgeInsets.only(
                    left: 8, right: 8, top: 16),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  // "PURCHASE PLAN",
                  "Try 7 days free Trial",
                  style: AppTextStyle.regular500.copyWith(
                      fontSize: 14,
                      color: AppColors.whiteColor),),
              ),
            ),
          )
        ],
      ),
    );
  }

  changeVisibility(int index) {
    setState(() {
      pricingScreenController.plansSHowHidBoolList[index] =
      !pricingScreenController.plansSHowHidBoolList[index];
    });
  }
}


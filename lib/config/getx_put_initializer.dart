import 'package:get/get.dart';
import 'package:grobiz_web_landing/agarb/test_flow/controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/intro_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/login_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_address_section/address_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_apps_demo_section/add_latest_project/add_Project_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_benefit_banner_section/edit_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/detailed_case_study_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/controller/edit_partner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_case_study_section/related_case_studies/types/cs_category_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_checkout_section/edit_checkoutController.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_faqs_section/faq_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_how_it_works_section/edit_hiw_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_info_section/edit_info_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_intro_section/edit_intro_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_mix_banner_section/edit_mix_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_numbers_banner_section/number_banner_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/blog_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/BlogSection/related_blog/types/blog_category_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_testimonials_section/testiMonalController.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_sections/edit_showcase_apps_section/showcase_app_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/checkout_info_section/CheckOutInfoControllers.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/career/careers_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/sections/info_section/Footer/helpController.dart';

getXPutInitializer() {
  Get.put(WebLandingPageController());
  // Get.put(TestController());
  Get.put(IntroSectionController());
  Get.put(LoginController());
  Get.put(EditController());
  Get.put(EditIntroController());
  Get.put(EditHiwController());
  Get.put(MixBannerController());
  Get.put(NumberBannerController());
  Get.put(ShowCaseAppsController());
  // Get.put(VideoController());
  Get.put(AddProjectController());
  Get.put(PricingScreenController());
  Get.put(EditInfoController());
  Get.put(CareersController());
  Get.put(HelpController());
  Get.put(EditCaseStudyController());
  Get.put(DetailCaseStudyController());
  Get.put(EditTestimonalController());

  Get.put(CheckOutInfoController());
  Get.put(EditBlogController());
  Get.put(BenefitBannerController());
  Get.put(EditCheckOutController());
  Get.put(CSCategoriesController());
  Get.put(BlogCategoriesController());
  Get.put(AddressController());
  Get.put(FaqController());



  Get.put(ControllerFile());
}

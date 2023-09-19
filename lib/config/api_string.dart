// ignore_for_file: constant_identifier_names

class APIString {
  APIString._();

  //grobiz.app - new
  //gruzen.in - old

  /// Base URL - test
  // static const String userAutoId = '648ff936ce83178580017422';
  //static const String grobizBaseUrl = 'https://gruzen.in/GrobizEcommerceSuperAdmin/api/';
  // static const String grobizBaseUrl = 'https://grobiz.app/GrobizEcommerceSuperAdminTest/api/';
  // static const String mediaBaseUrl = 'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/Web/';
  // static const String bannerMediaUrl = 'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/GWebsite/';
  // static const String latestmediaBaseUrl = 'https://grobiz.app/GrobizEcommerceSuperAdminTest/images/GWebsite/';

  /// Base URL - live
  static const String userAutoId = '64be46c89dc5f3d4f6065082';
  static const String grobizBaseUrl =
      'https://grobiz.app/GrobizEcommerceSuperAdmin/api/';
  static const String mediaBaseUrl =
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/Web/';
  static const String bannerMediaUrl =
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/GWebsite/';
  static const String latestmediaBaseUrl =
      'https://grobiz.app/GrobizEcommerceSuperAdmin/images/GWebsite/';

  static const String get_web_landing_page_data = "get_web_landing_page_data";
  static const String insert_web_landing_page_data =
      "insert_web_landing_page_data";
  static const String update_web_landing_page_data =
      "update_web_landing_page_data";

  static const String get_web_component_list = "get_web_component_list";
  static const String reordering_web_components = "reordering_web_components";
  static const String update_component_visibility =
      "update_component_visibility";

//login page api
  static const String login_landing_page = "login_landing_page";

//Coupon Code
  static const String get_web_coupon_code_list = "get_web_coupon_code_list";
  static const String generate_coupon_code = "generate_coupon_code";
  static const String get_user_count_list = "get_user_count_list";

//Get Plans
  static const String get_plans = "get_plans";
  static const String getPlansLandingPage = "get_plans_landing_page";

  //partner logos
  static const String add_number_banner = "add_number_banner";
  static const String edit_number_banner = "edit_number_banner";
  static const String get_number_banner = "get_number_banner";
  static const String delete_number_banner = "delete_number_banner";

  //app demo sections
  static const String add_app_created_by_grobiz = "add_app_created_by_grobiz";
  static const String get_app_created_by_grobiz = "get_app_created_by_grobiz";
  static const String delete_app_created_by_grobiz =
      "delete_app_created_by_grobiz";
  static const String edit_app_created_by_grobiz = "edit_app_created_by_grobiz";

  ///footer images
  static const String add_footer_banner = "add_footer_banner";
  static const String edit_footer_banner = "edit_footer_banner";
  static const String get_footer_banner = "get_footer_banner";
  static const String delete_footer_banner = "delete_footer_banner";
  static const String career_form = "career_form";

  //footer Section
  static const String AboutUs = "showAbout";
  static const String TandC = "showTermsCondition";
  static const String showPrivacy = "showPrivacy";
  static const String showContactDetails = "showContactDetails";
  static const String showFaqs = "showFaqs";
  static const String showRefundPolicy = "showRefundPolicy";

  //editpartnerlogo
  static const String addCaseStudy = "add_case_study";
  static const String editCaseStudy = "edit_case_study";
  static const String getCaseStudy = "get_case_study";
  static const String deleteCaseStudy = "delete_case_study";

  //editPartnerLogo
  static const String addCaseStudyDetails = "add_case_study_details";
  static const String editCaseStudyDetails = "edit_case_study_details";
  static const String getCaseStudyDetails = "get_case_study_details";
  static const String deleteCaseStudyDetails = "delete_case_study_details";

  //Testimonial Section
  static const String add_app_logo_list = "add_app_logo_list";
  static const String edit_app_logo_list = "edit_app_logo_list";
  static const String get_app_logo_list = "get_app_logo_list";
  static const String delete_app_logo_list = "delete_app_logo_list";

  static const String get_testimonials = "get_testimonials";
  static const String add_testimonials = "add_testimonials";
  static const String edit_testimonials = "edit_testimonials";
  static const String delete_testimonials = "delete_testimonials";

  ///blog section
  static const String get_blog = "get_blog";
  static const String edit_blog = "edit_blog";
  static const String add_blog = "add_blog";
  static const String delete_blog = "delete_blog";

  ///blog details Section
  static const String get_blog_details = "get_blog_details";
  static const String add_blog_details = "add_blog_details";
  static const String edit_blog_details = "edit_blog_details";
  static const String delete_blog_details = "delete_blog_details";

  //check out Info section
  static const String get_checkout = "get_checkout";
  static const String add_checkout = "add_checkout";
  static const String edit_checkout = "edit_checkout";
  static const String delete_checkout = "delete_checkout";

  //ShowCase App
  static const String get_userlist = "get_userlist";
  static const String add_userlist = "add_userlist";
  static const String edit_userlist = "edit_userlist";
  static const String delete_userlist = "delete_userlist";

  //Edit Banner Model
  static const String get_benefit_list = "get_benefit_list";
  static const String add_benefit_list = "add_benefit_list";
  static const String edit_benefit_list = "edit_benefit_list";
  static const String delete_benefit_list = "delete_benefit_list";

  //Related Case Studies & Categories
  static const String related_casestudy = "related_casestudy";
  static const String case_study_type_add = "case_study_type_add";
  static const String case_study_type_update = "case_study_type_update";
  static const String case_study_type_delete = "case_study_type_delete";
  static const String case_study_type_get = "case_study_type_get";

  //Related Blogs & Categories
  static const String related_blog = "related_blog";
  static const String blog_type_add = "blog_type_add";
  static const String blog_type_update = "blog_type_update";
  static const String blog_type_delete = "blog_type_delete";
  static const String blog_type_get = "blog_type_get";

  //FAQs
  static const String add_faq_type = "add_faq_type";
  static const String update_faq_type = "update_faq_type";
  static const String delete_faq_type = "delete_faq_type";
  static const String get_faq_type = "get_faq_type";

  //FAQs details
  static const String add_faq = "add_faq";
  static const String update_faq = "update_faq";
  static const String delete_faq = "delete_faq";
  static const String get_faq = "get_faq";
}

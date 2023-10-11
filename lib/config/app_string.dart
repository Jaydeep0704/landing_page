import 'package:grobiz_web_landing/widget/common_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AppString {
  AppString._();

  static const String login = "Log in";

  ///btn ontap redirect links
  static const String ytLink =
      "https://youtube.com/@grobiz9049?si=OcdTDkfwm4bk1xp-";
  static const String fbLink = "https://www.facebook.com/grobizapp";
  static const String instaLink = "https://www.instagram.com/grobiz2020/";
  static const String twitterLink = "https://twitter.com/GrobizAi";
  static const String linkedInLink =
      "https://www.linkedin.com/in/grobiz-ai-app-builder-72a441289";
  static const String playStoreAppLink =
      "https://play.google.com/store/apps/details?id=com.efunhub.grobizz";
  static const String websiteLink = "https://grobiz.app/Grobizweb/build/web/#/";
}

class UrlLauncherUtil {
  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      // await launch(url);
      await launchUrl(url);
      showSnackbar( message: "Opened Link");
    } else {
      showSnackbar( message: "Error");
      throw 'Could not launch $url';
    }
  }
}

void appOpen() async {
  const url = AppString.playStoreAppLink;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void websiteOpen() async {
  const url = AppString.websiteLink;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

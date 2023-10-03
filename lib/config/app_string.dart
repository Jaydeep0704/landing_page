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
      print("launch :: $url");
      // await launch(url);
      await launchUrl(url);
    } else {
      print("Could not launch $url");
      throw 'Could not launch $url';
    }
  }
}

import 'dart:html' as html;

class PlatformUtil {
  static bool isPlatform(String platform) {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains(platform.toLowerCase());
  }

  static bool isAndroid() {
    return isPlatform('Android');
  }

  static bool isiOS() {
    return isPlatform('iPhone') || isPlatform('iPad');
  }

  static bool isWindows() {
    return isPlatform('Windows');
  }

  static bool isMacOS() {
    return isPlatform('Macintosh');
  }
}

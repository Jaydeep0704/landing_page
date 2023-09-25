import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_string.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/edit_controller.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/controller/landing_page_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final webLandingPageController = Get.find<WebLandingPageController>();
  final editController = Get.find<EditController>();

  @override
  void initState() {
    super.initState();

    getDataFunction();
  }

  getDataFunction() {
    Future.delayed(
      Duration.zero,
      () {
        editController.getData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 600 ? 400 : null,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                color: Colors.red,
              ),
              const SizedBox(height: 20.0),
              commonIconButton(
                  onTap: () async {
                    const url = AppString.playStoreAppLink;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icons.phone_android,
                  title: "Create Your App",
                  btnColor: Colors.redAccent.withOpacity(0.7),
                  txtColor: Colors.white),
              commonIconButton(
                  onTap: () async {
                    const url = AppString.websiteLink;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icons.phone_android,
                  title: "Create Your web",
                  btnColor: Colors.redAccent.withOpacity(0.7),
                  txtColor: Colors.white),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

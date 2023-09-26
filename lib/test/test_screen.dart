import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

///

class ScrollMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll ListView with Arrow Keys'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: 100, // Adjust as needed
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Add a listener for keyboard events
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  final ScrollController _controller = ScrollController();
  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _scrollListView(-1);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _scrollListView(1);
      }
    }
  }

  void _scrollListView(int direction) {
    final double scrollAmount =
        direction * 100.0; // Adjust the scroll amount as needed
    _controller.animateTo(
      _controller.offset + scrollAmount,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    RawKeyboard.instance.removeListener(_handleKeyPress);
    _controller.dispose();
    super.dispose();
  }
}

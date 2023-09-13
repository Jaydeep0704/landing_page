import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogsTypeCrudScreen extends StatefulWidget {
  const BlogsTypeCrudScreen({super.key});

  @override
  State<BlogsTypeCrudScreen> createState() => _BlogsTypeCrudScreenState();
}

class _BlogsTypeCrudScreenState extends State<BlogsTypeCrudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Blog Categories",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => {Navigator.of(context).pop()},
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Row(children: [
            const Expanded(child: SizedBox()),
            SizedBox(
              width: Get.width > 800 ? 500 : 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
            const Expanded(child: SizedBox()),
          ]),
        ),
      ),
    );
  }
}

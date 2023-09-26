import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  List<String> data = []; // Replace with your data source

  int currentPage = 1; // Track the current page of data

  @override
  void initState() {
    super.initState();
    fetchData();
    itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _onScroll() {
    if (itemPositionsListener.itemPositions.value.last.index ==
        data.length - 1) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progressive Loading'),
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
          );
        },
      ),
    );
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.example.com/data?page=$currentPage'));
    if (response.statusCode == 200) {
      final List<String> newData = parseResponse(response.body);
      setState(() {
        data.addAll(newData);
        currentPage++;
      });
    }
  }

  List<String> parseResponse(String responseBody) {
    // Implement the parsing logic here based on your API response format
    // For example, if your API response is a list of strings, you can parse it like this:
    final List<dynamic> parsedJson = jsonDecode(responseBody);
    return parsedJson.map((dynamic item) => item.toString()).toList();
  }
}

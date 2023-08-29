import 'package:flutter/material.dart';

class YourParentWidget extends StatefulWidget {
  @override
  _YourParentWidgetState createState() => _YourParentWidgetState();
}

class _YourParentWidgetState extends State<YourParentWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          key: UniqueKey(), // Use UniqueKey for each class
          child: getClassWidget(index, _scrollController),
        );
      },
    );
  }

  Widget getClassWidget(int index, ScrollController scrollController) {
    return const Scaffold();

  }
}

class Class1 extends StatelessWidget {
  final GlobalKey _class5Key; // The global key of Class5

  Class1(this._class5Key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... other widgets ...
        ElevatedButton(
          onPressed: () {
            // Scroll to Class5 when button is tapped in Class1
            Scrollable.ensureVisible(
              _class5Key.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Text('Scroll to Class5'),
        ),
      ],
    );
  }
}

class Class5 extends StatefulWidget {
  @override
  _Class5State createState() => _Class5State();
}

class _Class5State extends State<Class5> {
  final GlobalKey _class5Key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _class5Key,
      children: [
        // ... other Class5 UI ...

        ElevatedButton(
          onPressed: () {
            // Scroll to Class5 itself
            Scrollable.ensureVisible(
              _class5Key.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Text('Scroll to Class5'),
        ),
      ],
    );
  }
}

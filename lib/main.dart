import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'body.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade100),
      useMaterial3: true,
    ),
    home: const HomeWidget(),
  ));
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset('assets/images/logo/kca_logo.png')),
        leadingWidth: 100,
      ),
      body: Body(index: index),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (newIndex) => setState(() => index = newIndex),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 28), label: 'detection'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt, size: 28), label: 'result'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu, size: 28), label: 'menu'),
          ]),
    );
  }
}

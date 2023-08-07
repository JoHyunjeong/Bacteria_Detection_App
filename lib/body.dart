import 'package:detection2/screen/detection/s_detection.dart';
import 'package:detection2/screen/menu/s_menu.dart';
import 'package:detection2/screen/result/s_result.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final int index;

  const Body({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const DetectionScreen();
    } else if (index == 1) {
      return const ResultScreen();
    } else {
      return const MenuScreen();
    }
  }
}

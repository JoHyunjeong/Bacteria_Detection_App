import 'package:flutter/material.dart';

class OpenSourceWidget extends StatelessWidget {
  const OpenSourceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Open Source')),
      body: Center(child: Text('🤡',style:TextStyle(fontSize:150,)))
    );
  }
}

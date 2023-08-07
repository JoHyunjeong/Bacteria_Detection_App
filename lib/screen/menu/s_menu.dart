import 'package:detection2/screen/menu/w_account.dart';
import 'package:detection2/screen/menu/w_opensource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}



class _MenuScreenState extends State<MenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountWidget()));
          },
          icon: Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade100),
            child: const Row(
              children: [
                Icon(CupertinoIcons.person, size: 30),
                SizedBox(width: 10),
                Text('Account',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ).paddingOnly(left: 20),
          ),
        ),
        SizedBox(height: 5),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OpenSourceWidget()));
          },
          icon: Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade100),
            child: const Row(
              children: [
                Icon(CupertinoIcons.book, size: 30),
                SizedBox(width: 10),
                Text('OpenSource',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ).paddingOnly(left: 20),
          ),
        ),

      ],
    ).paddingAll(20);
  }
}

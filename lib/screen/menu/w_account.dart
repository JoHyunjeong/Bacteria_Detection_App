import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Account')),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 150),
          child: Column(children: [
            Icon(CupertinoIcons.person_alt_circle, size: 200, color: Colors.grey),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('계정 : hjjo@kca21.com', style: TextStyle(fontSize: 20)),
                SizedBox(height: 7),
                Text('회사명 : 케이씨에이', style: TextStyle(fontSize: 20)),
                SizedBox(height: 7),
                Text('소속부서 : 데이터바우처팀', style: TextStyle(fontSize: 20)),
                SizedBox(height: 7),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                TextButton(onPressed: () {}, child: Text('비밀번호 변경')),
                Expanded(child: Container()),
              ],
            )
          ]),
        ));
  }
}

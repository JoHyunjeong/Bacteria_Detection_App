import 'dart:io';

import 'package:detection2/screen/result/vo_list.dart';
import 'package:detection2/screen/result/w_edit_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultDetailWidget extends StatefulWidget {
  final int index;

  const ResultDetailWidget({
    required this.index,
    super.key,
  });

  @override
  State<ResultDetailWidget> createState() => _ResultDetailWidgetState();
}

class _ResultDetailWidgetState extends State<ResultDetailWidget> {
  @override
  Widget build(BuildContext context) {
    String imgPath = resultList[widget.index][0];
    String site = resultList[widget.index][1];
    String location = resultList[widget.index][2];
    ClassValue cls = resultList[widget.index][3];

    return Scaffold(
        appBar: AppBar(title: Text('Detail')),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(CupertinoIcons.pencil),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDetailWidget(index: widget.index, cls: cls)));
                    }),
                IconButton(
                  icon: const Icon(CupertinoIcons.delete),
                  onPressed: () {
                    _deleteDialog(index: widget.index);
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Image.file(File(imgPath), width: 300, height: 300),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SITE : ${site}',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('LOCATION : ${location}',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('CLASS : ${cls.name}',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('COLONY : 10', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ).paddingAll(40),
          ],
        ));
  }

  void _deleteDialog({required index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: const Text("분석 결과를 삭제하시겠습니까?"),
          contentTextStyle: TextStyle(fontSize: 15, color: Colors.black),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            TextButton(
              child: const Text("예"),
              onPressed: () {
                setState(() {
                  resultList.removeAt(index);
                });
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("아니오"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

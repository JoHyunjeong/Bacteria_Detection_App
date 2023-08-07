import 'dart:io';
import 'package:detection2/screen/result/vo_list.dart';
import 'package:detection2/screen/result/w_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/w_line.dart';

class ResultWidget extends StatefulWidget {
  final String imgPath;

  const ResultWidget(
      {required this.imgPath,
      super.key});

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    var _index = resultList.indexWhere((element) => element[0] == widget.imgPath);
    String site = resultList[_index][1];
    String location = resultList[_index][2];
    ClassValue cls = resultList[_index][3];


    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.file(File(widget.imgPath), height: 120),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SITE : ${site}'),
                      Text('LOCATION : ${location}'),
                      Text('CLASS : ${cls.name}'),
                      Text('COLONY : 10'),
                    ]),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultDetailWidget(
                                index: _index)));
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ).paddingAll(5),
        Line(color: Colors.grey.shade300)
      ],
    );
  }
}

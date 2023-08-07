import 'package:detection2/screen/result/vo_list.dart';
import 'package:detection2/screen/result/w_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../common/w_line.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<String> dropdownList = ['all', 'bacteria', 'molds'];
  String selectedDropdown = 'all';

  @override
  final total = resultList.length.toString();

  Widget build(BuildContext context) {
    if (resultList.length >= 1) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(child: Container(width: 15)),
                  DropdownButton(
                    underline: const SizedBox.shrink(),
                    value: selectedDropdown,
                    items: dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                          value: item, child: Text(item));
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedDropdown = value;
                      });
                    },
                  ),
                  SizedBox(child: Container(width: 10)),
                  if (selectedDropdown=='all')...[
                    Text('전체 $total건')
                  ] else if (selectedDropdown=='bacteria')...[
                    Text('${resultList.where((data) => data[3] == ClassValue.bacteria).length.toString()}건')
                  ] else...[
                    Text('${resultList.where((data) => data[3] == ClassValue.molds).length.toString()}건')
                  ],
                  Expanded(child: Container()),
                  IconButton(
                    icon: const Icon(CupertinoIcons.trash, size: 25),
                    onPressed: () {
                      _deleteAllDialog();
                    },
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.share, size: 25),
                    onPressed: () {
                      _sendEmail();
                    },
                  ),
                ],
              ),
              Line(color: Colors.grey.shade300),
              if (selectedDropdown == 'all') ...[
                ...resultList.reversed.map((e) => ResultWidget(imgPath: e[0])).toList()
              ] else if (selectedDropdown == 'bacteria') ...[
                ...resultList.where((data) => data[3] == ClassValue.bacteria).toList().reversed
                    .map((e) => ResultWidget(imgPath: e[0])).toList()
              ] else...[
                ...resultList.where((data) => data[3] == ClassValue.molds).toList().reversed
                    .map((e) => ResultWidget(imgPath: e[0])).toList()
              ]
            ],
          ),
        ),
      );
    } else {
      return const Center(child: Text('분석 결과가 없습니다.'));
    }
  }

  void _sendEmail() async {
    final Email email = Email(
      recipients: ['onionfamily.official@gmail.com'],
      subject: 'Bacteria Analysis Results',
      body: 'test',
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.";
      String message = "";
      print(title);
      print(message);
    }
  }

  Future sleepAsync(Duration duration) {
    return Future.delayed(duration, () => {});
  }

  void _deleteAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: const Text("분석 결과를 모두 삭제하시겠습니까?"),
          contentTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            TextButton(
              child: const Text("예"),
              onPressed: () {
                setState(() {
                  resultList.clear();
                });
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

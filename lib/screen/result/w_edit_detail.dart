import 'dart:io';

import 'package:detection2/screen/result/vo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDetailWidget extends StatefulWidget {
  final ClassValue cls;
  final int index;

  const EditDetailWidget({required this.index, required this.cls, super.key});

  @override
  State<EditDetailWidget> createState() => _EditDetailWidgetState();
}

class _EditDetailWidgetState extends State<EditDetailWidget> {


  String new_site = '';
  String new_location = '';
  ClassValue? selectValue;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectValue = widget.cls;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정보 수정'),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              print(resultList[widget.index][3]);
            },
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.file(File(resultList[widget.index][0]),
                      width: 280, height: 280)),
              SizedBox(height: 20),
              editBox(
                  label: 'SITE',
                  label_index: 1,
                  onSaved: (val) {
                    new_site = val;
                  }),
              editBox(
                  label: 'LOCATION',
                  label_index: 2,
                  onSaved: (val) {
                    new_location = val;
                  }),
              Row(
                children: [
                  Text('CLASS : '),
                  SizedBox(width:60),
                  Row(
                    children: [
                      Radio<ClassValue>(
                          value: ClassValue.bacteria,
                          groupValue: selectValue,
                          onChanged: (value) => setState(() => selectValue = value)),
                      Text(ClassValue.bacteria.name),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<ClassValue>(
                          value: ClassValue.molds,
                          groupValue: selectValue,
                          onChanged: (value) => setState(() => selectValue = value)),
                      Text(ClassValue.molds.name),
                    ],
                  ),
                ],
              ),
              Row(children: [
                Text('COLONY : '),
                Expanded(child: Container()),
                Container(
                    padding: EdgeInsets.only(left: 15),
                    width: 250,
                    height: 60,
                    child:
                        Align(alignment: Alignment.centerLeft, child: Text('10')))
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.save();
                      if (new_site.length > 1) {
                        resultList[widget.index][1] = new_site;
                      }
                      if (new_location.length > 1) {
                        resultList[widget.index][2] = new_location;
                      }
                      resultList[widget.index][3] = selectValue;
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ).paddingAll(20.0),
        ),
      ),
    );
  }

  editBox({
    required String label,
    required int label_index,
    required FormFieldSetter onSaved,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text('${label} : '),
            Expanded(child: Container()),
            TextFormField(
              onSaved: onSaved,
              decoration: InputDecoration(
                isDense: true,
                constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                hintText: resultList[widget.index][label_index],
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(width: 1, color: Colors.indigo),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

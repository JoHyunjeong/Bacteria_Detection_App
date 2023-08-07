import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../result/vo_list.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  ClassValue? selectValue = ClassValue.bacteria;
  File? _image;
  final formKey = GlobalKey<FormState>();
  String site = '';
  String location = '';
  final _siteTextEditController = TextEditingController();
  final _locationTextEditController = TextEditingController();

  Future getImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path);
    });
  }

  Widget showImage() {
    return InkWell(
      onTap: (){
        getImage(ImageSource.camera);
      },
      child:Container(
        color: _image == null ? Colors.grey.shade200 : Colors.white,
        width: 330, // width: MediaQuery.of(context).size.width,
        height: 330, // height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))))
    );
  }

  @override
  void dispose() {
    _siteTextEditController.dispose();
    _locationTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              showImage(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('CLASS : ',style:TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width:20),
                  Row(
                    children: [
                      Radio<ClassValue>(
                          value: ClassValue.bacteria,
                          groupValue: selectValue,
                          onChanged: (value) => setState(() => selectValue = value)),
                      Text(ClassValue.bacteria.name),
                    ],
                  ),
                  SizedBox(width:20),
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
              ).paddingOnly(left:17),
              const SizedBox(height: 10),
              renderTextFormField(
                label: 'SITE',
                onSaved: (val) {
                  setState(() {
                    site = val;
                  });
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '현장명을 입력해주세요.';
                  }
                  return null;
                },
                controller: _siteTextEditController,
              ),
              renderTextFormField(
                label: 'LOCATION',
                onSaved: (val) {
                  setState(() {
                    location = val;
                  });
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '측정지점을 입력해주세요.';
                  }
                  return null;
                },
                controller: _locationTextEditController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (_image != null) {
                      resultList.add([_image!.path, site, location, selectValue]);
                      setState(() {
                        _image = null;
                        _siteTextEditController.clear();
                        _locationTextEditController.clear();
                      });
                      showSnackBar(
                          title: '저장완료',
                          content: 'result탭에서 결과를 확인하세요.',
                          color: Colors.indigo);
                    } else {
                      showSnackBar(
                          title: 'Error',
                          content: '사진을 촬영해 주세요.',
                          color: const Color(0xffBD1709));
                    }
                  }
                },
                child: const Text('RUN'),
              ),
            ],
          ).paddingAll(20),
        ),
      ),
    );
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required TextEditingController controller,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            Text('${label} : ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            TextFormField(
              onSaved: onSaved,
              validator: validator,
              controller: controller,
              decoration: const InputDecoration(
                isDense:true,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 230),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(width: 1, color: Colors.indigo),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(width: 1, color: Color(0xffD2D2D2)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    ).paddingSymmetric(horizontal: 17);
  }

  void showSnackBar({
    required String title,
    required String content,
    required Color color,
  }) {
    Get.snackbar(title, content,
        colorText: color,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }
}

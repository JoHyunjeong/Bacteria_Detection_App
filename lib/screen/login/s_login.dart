import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            renderTextFormField(
              label: '이름',
              onSaved: (val) {
                setState(() {
                  name = val;
                });
              },
              validator: (val) {
                if (val.length < 1) {
                  return '이름은 필수사항입니다.';
                }
                return null;
              },
            ),
            renderTextFormField(
              label: '이메일',
              onSaved: (val) {
                email = val;
              },
              validator: (val) {
                if (val.length < 1) {
                  return '이메일은 필수사항입니다.';
                }
                return null;
              },
            ),
            renderTextFormField(
              label: '비밀번호',
              onSaved: (val) {
                password = val;
              },
              validator: (val) {
                if (val.length < 1) {
                  return '비밀번호는 필수사항입니다.';
                }
                return null;
              },
            ),
            renderButton(),
            FloatingActionButton(
                onPressed: () {
                  print(password);
                  showSnackBar(title:'test', content: 'testㅈ');
                },
                child: Icon(Icons.home))
          ],
        ),
      ),
    );
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            )
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  renderButton() {
    return OutlinedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          showSnackBar(title: '저장완료', content: '폼 저장이 완료되었습니다.');
        }
      },
      child: Text(
        '저장하기',
        style: TextStyle(
          color: Colors.indigo,
        ),
      ),
    );
  }

  void showSnackBar({
    required String title,
    required String content,
  }) {
    Get.snackbar(title, content,
        colorText: Colors.indigo,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

}

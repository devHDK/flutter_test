import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            hintText: '이메일을 입력해주세요',
            errorText: '에러가 있습니다',
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            hintText: '비밀번호를 입력해주세요',
            errorText: '에러가 있습니다',
            onChanged: (value) {},
            obscureText: true,
          ),
        ],
      )),
    );
  }
}

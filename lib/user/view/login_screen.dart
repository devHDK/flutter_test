import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/user/model/user_model.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                const _subTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  errorText: '에러가 있습니다',
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  errorText: '에러가 있습니다',
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () {
                          ref
                              .read(userMeProvider.notifier)
                              .login(username: username, password: password);
                          // try {
                          //   String rawString = '$username:$password';
                          //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
                          //   String token = stringToBase64.encode(rawString);

                          //   final response = await dio.post(
                          //     'http://$ip/auth/login',
                          //     options:
                          //         Options(headers: {'authorization': 'Basic $token'}),
                          //   );

                          //   final refreshToken = response.data['refreshToken'];
                          //   final accessToken = response.data['accessToken'];
                          //   final storage = ref.read(seccureStorageProvider);

                          //   await storage.write(
                          //       key: REFRESH_TOKEN_KEY, value: refreshToken);
                          //   await storage.write(
                          //       key: ACCESS_TOKEN_KEY, value: accessToken);

                          //   Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const RootTab(),
                          //   ));
                          // } catch (e) {
                          //   print(e);
                          // }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: state is! UserModelLoading
                      ? const Text('로그인')
                      : const SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator()),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      textAlign: TextAlign.start,
    );
  }
}

class _subTitle extends StatelessWidget {
  const _subTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!\n 오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

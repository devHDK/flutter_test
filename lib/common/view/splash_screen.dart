import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashSceen extends ConsumerStatefulWidget {
  const SplashSceen({super.key});

  @override
  ConsumerState<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends ConsumerState<SplashSceen> {
  @override
  void initState() {
    super.initState();
    // FlutterSecureStorage.setMockInitialValues({});

    checkToken();
  }

  void checkToken() async {
    final storage = ref.read(seccureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final response = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(
          key: ACCESS_TOKEN_KEY, value: response.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 16,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}

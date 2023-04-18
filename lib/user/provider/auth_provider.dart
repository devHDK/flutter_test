import 'package:actual/common/view/root_tab.dart';
import 'package:actual/common/view/splash_screen.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:actual/user/model/user_model.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
        GoRoute(
            path: '/',
            name: RootTab.routeName,
            builder: (context, state) => const RootTab(),
            routes: [
              GoRoute(
                path: 'restaurant/:rid',
                name: RestaurantDetailScreen.routeName,
                builder: (context, state) => RestaurantDetailScreen(
                  id: state.params['rid']!,
                ),
              )
            ]),
        GoRoute(
          path: '/splash',
          name: SplashSceen.routeName,
          builder: (context, state) => const SplashSceen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  //splashScreen
  //앱을 처음 시작했을때 토큰이 존재하는지 확인하고 로그인 스크린으로 보내줄지 , 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final loginIn = state.location == '/login';

    if (user == null) {
      return loginIn ? null : '/login';
    }

    //user != null

    //UserModel
    //로그인 중이거나 현재 위치가 splashScreen이면 홈으로 이동
    if (user is UserModel) {
      return loginIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return loginIn ? '/login' : null;
    }

    return null;
  }
}

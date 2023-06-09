import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/view/product_screen.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:actual/user/view/profile_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListner);
  }

  @override
  void dispose() {
    controller.removeListener(tabListner);

    super.dispose();
  }

  void tabListner() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '딜리버리',
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (index) {
            print(index);

            controller.animateTo(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood_outlined,
              ),
              label: '음식',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: '주문',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: '프로필',
            )
          ]),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          const RestaurentScreen(),
          const ProductScreen(),
          Center(
            child: Container(
              child: const Text('order'),
            ),
          ),
          const ProfileScreen()
        ],
      ),
    );
  }
}

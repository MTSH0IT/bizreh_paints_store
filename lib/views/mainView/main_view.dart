import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/main_view_controller.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/views/home/home_view.dart';
import 'package:bizreh_paints_store/views/myCart/my_cart_view.dart';
import 'package:bizreh_paints_store/views/profile/profile_view.dart';
import 'package:bizreh_paints_store/views/search/search.dart';

class MainView extends StatelessWidget {
  MainView({super.key});
  final controller = Get.put(MainViewController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: [HomeView(), Search(), MyCartView(), ProfileView()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => controller.selectedIndex.value = i,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

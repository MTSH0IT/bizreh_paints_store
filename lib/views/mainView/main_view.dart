import 'package:bizreh_paints_store/views/wishList/wish_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/controllers/main_view_controller.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/views/home/home_view.dart';
import 'package:bizreh_paints_store/views/myCart/my_cart_view.dart';
import 'package:bizreh_paints_store/views/profile/profile_view.dart';
import 'package:bizreh_paints_store/views/search/search.dart';
import 'package:bizreh_paints_store/views/gifts/gifts_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainViewController>();
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              HomeView(),
              GiftsView(),
              Search(),
              WishList(),
              MyCartView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => controller.selectedIndex.value = i,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'home.title'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.card_giftcard),
              label: 'gifts.title'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'search.search'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              label: 'wishlist.title'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              label: 'cart.title'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: 'profile.account'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/views/eranedPoints/eraned_points_view.dart';
import 'package:bizreh_paints_store/views/orderHistory/order_history.dart';
import 'package:bizreh_paints_store/views/personalInformation/personal_information_view.dart';
import 'package:bizreh_paints_store/views/savedAddress/saved_address_view.dart';
import 'package:bizreh_paints_store/views/settings/settings_view.dart';
import 'package:bizreh_paints_store/views/wishList/wish_list.dart';
import 'widgets/profile_list_item.dart';
import 'widgets/section_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              //const ProfileHeader(name: 'mohammad altaher'),
              const SectionTitle(title: 'Account'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Personal Information',
                      onTap: () {
                        Get.to(() => PersonalInformation());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.star_outline_rounded,
                      title: 'Earned Points',
                      //trailingText: '1,250',
                      onTap: () {
                        Get.to(() => const EranedPointsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.location_on_outlined,
                      title: 'Addresses',
                      onTap: () {
                        Get.to(() => const SavedAddressView());
                      },
                    ),
                  ],
                ),
              ),

              const SectionTitle(title: 'Orders'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                      icon: Icons.local_shipping_outlined,
                      title: 'Order History',
                      onTap: () {
                        // Get.to(() => const OrderHistory());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'Wish List',
                      onTap: () {
                        Get.to(() => WishList());
                      },
                    ),
                  ],
                ),
              ),

              const SectionTitle(title: 'Settings'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                    ),
                    ProfileListItem(
                      icon: Icons.settings_outlined,
                      title: 'App Preferences',
                      onTap: () {
                        Get.to(() => SettingsView());
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

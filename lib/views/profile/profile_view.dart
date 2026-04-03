import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/views/orderHistory/order_history.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:url_launcher/url_launcher.dart';
import 'package:bizreh_paints_store/views/eranedPoints/eraned_points_view.dart';
import 'package:bizreh_paints_store/views/personalInformation/personal_information_view.dart';
import 'package:bizreh_paints_store/views/savedAddress/saved_address_view.dart';
import 'package:bizreh_paints_store/views/settings/settings_view.dart';
import 'package:bizreh_paints_store/views/notifications/notifications_view.dart';
import 'package:bizreh_paints_store/views/wishList/wish_list_view.dart';
import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'widgets/profile_list_item.dart';
import 'widgets/section_title.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static final Uri _websiteUri = Uri.parse('https://www.bizrehpaints.com/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              SectionTitle(title: tr('profile.account')),
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
                      title: tr('profile.personal_info'),
                      onTap: () {
                        Get.to(() => PersonalInformation());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.star_outline_rounded,
                      title: tr('profile.earned_points'),
                      //trailingText: '1,250',
                      onTap: () {
                        Get.to(() => const EranedPointsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.location_on_outlined,
                      title: tr('profile.addresses'),
                      onTap: () {
                        Get.to(() => const SavedAddressView());
                      },
                    ),
                  ],
                ),
              ),

              SectionTitle(title: tr('profile.orders')),
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
                      title: tr('profile.order_history'),
                      onTap: () {
                        Get.find<OrderController>().loadOrderHistory();
                        Get.to(() => const OrderHistory());
                      },
                    ),
                    // ProfileListItem(
                    //   icon: Icons.local_offer_outlined,
                    //   title: tr('rewards.title'),
                    //   onTap: () {
                    //     Get.to(() => const RewardsView());
                    //   },
                    // ),
                    ProfileListItem(
                      icon: Icons.favorite_border_rounded,
                      title: tr('profile.wish_list'),
                      onTap: () {
                        Get.to(() => WishList());
                      },
                    ),
                  ],
                ),
              ),

              SectionTitle(title: tr('profile.settings')),
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
                      title: tr('profile.notifications'),
                      onTap: () {
                        Get.to(() => NotificationsView());
                      },
                    ),

                    ProfileListItem(
                      icon: Icons.settings_outlined,
                      title: tr('profile.app_preferences'),
                      onTap: () {
                        Get.to(() => SettingsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.public_outlined,
                      title: tr('profile.official_website'),
                      onTap: () async {
                        await launchUrl(
                          _websiteUri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.logout_outlined,
                      title: tr('settings.logout'),
                      destructive: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            title: tr('settings.logout_dialog.title'),
                            message: tr('settings.logout_dialog.message'),
                            confirmText: tr('settings.logout_dialog.confirm'),
                            cancelText: tr('settings.logout_dialog.cancel'),
                            isDestructive: false,
                            onConfirm: () {
                              Get.find<PersonalController>().signOut();
                            },
                          ),
                        );
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

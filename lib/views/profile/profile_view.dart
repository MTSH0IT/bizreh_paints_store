import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/views/orderHistory/order_history.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              SectionTitle(title: 'profile.account'.tr()),
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
                      title: 'profile.personal_info'.tr(),
                      onTap: () {
                        Get.to(() => PersonalInformation());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.star_outline_rounded,
                      title: 'profile.earned_points'.tr(),
                      //trailingText: '1,250',
                      onTap: () {
                        Get.to(() => const EranedPointsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.location_on_outlined,
                      title: 'profile.addresses'.tr(),
                      onTap: () {
                        Get.to(() => const SavedAddressView());
                      },
                    ),
                  ],
                ),
              ),

              SectionTitle(title: 'profile.orders'.tr()),
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
                      title: 'profile.order_history'.tr(),
                      onTap: () {
                        Get.find<OrderController>().loadOrderHistory();
                        Get.to(() => const OrderHistory());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'profile.wish_list'.tr(),
                      onTap: () {
                        Get.to(() => WishList());
                      },
                    ),
                  ],
                ),
              ),

              SectionTitle(title: 'profile.settings'.tr()),
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
                      title: 'profile.notifications'.tr(),
                      onTap: () {
                        Get.to(() => NotificationsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.settings_outlined,
                      title: 'profile.app_preferences'.tr(),
                      onTap: () {
                        Get.to(() => SettingsView());
                      },
                    ),
                    ProfileListItem(
                      icon: Icons.logout_outlined,
                      title: 'settings.logout'.tr(),
                      destructive: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmationDialog(
                            title: 'settings.logout_dialog.title'.tr(),
                            message: 'settings.logout_dialog.message'.tr(),
                            confirmText: 'settings.logout_dialog.confirm'.tr(),
                            cancelText: 'settings.logout_dialog.cancel'.tr(),
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

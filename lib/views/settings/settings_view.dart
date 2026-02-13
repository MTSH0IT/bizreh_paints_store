import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:bizreh_paints_store/views/settings/change_password_view.dart';
import 'package:bizreh_paints_store/views/settings/delete_account_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final PersonalController personalController = Get.find<PersonalController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SettingsTile(
                    title: 'settings.language'.tr(),
                    onTap: () async {
                      final result = await showDialog<Locale>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('settings.choose_language'.tr()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('settings.arabic'.tr()),
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pop(const Locale('ar'));
                                  },
                                ),
                                ListTile(
                                  title: Text('settings.english'.tr()),
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pop(const Locale('en'));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );

                      if (result != null) {
                        await context.setLocale(result);
                      }
                    },
                  ),
                  SettingsTile(
                    title: 'settings.change_password'.tr(),
                    onTap: () {
                      Get.to(() => ChangePasswordView());
                    },
                  ),
                  // const SettingsTile(title: 'Contact Support'),
                  // const SettingsTile(title: 'Submit a Complaint'),
                  // const SettingsTile(title: 'Privacy Policy'),
                  // const SettingsTile(title: 'Terms of Service'),
                  SettingsTile(
                    title: 'settings.delete_account'.tr(),
                    destructive: true,
                    onTap: () {
                      Get.to(() => DeleteAccountView());
                    },
                  ),
                  SettingsTile(
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
                            personalController.signOut();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

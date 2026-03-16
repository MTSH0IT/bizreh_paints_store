import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
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
      appBar: const CommonAppBar(titleKey: 'settings.title'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SettingsTile(
                    title: tr('settings.language'),
                    onTap: () async {
                      final result = await showDialog<Locale>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(tr('settings.choose_language')),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(tr('settings.arabic')),
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pop(const Locale('ar'));
                                  },
                                ),
                                ListTile(
                                  title: Text(tr('settings.english')),
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
                    title: tr('settings.change_password'),
                    onTap: () {
                      Get.to(() => ChangePasswordView());
                    },
                  ),
                  // const SettingsTile(title: 'Contact Support'),
                  // const SettingsTile(title: 'Submit a Complaint'),
                  // const SettingsTile(title: 'Privacy Policy'),
                  // const SettingsTile(title: 'Terms of Service'),
                  SettingsTile(
                    title: tr('settings.delete_account'),
                    destructive: true,
                    onTap: () {
                      Get.to(() => DeleteAccountView());
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

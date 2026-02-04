import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:bizreh_paints_store/views/settings/change_password_view.dart';
import 'package:bizreh_paints_store/views/settings/delete_account_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final PersonalController personalController = Get.find<PersonalController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
                  const SettingsTile(title: 'Language'),
                  SettingsTile(
                    title: 'Change Password',
                    onTap: () {
                      Get.to(() => ChangePasswordView());
                    },
                  ),
                  // const SettingsTile(title: 'Contact Support'),
                  // const SettingsTile(title: 'Submit a Complaint'),
                  // const SettingsTile(title: 'Privacy Policy'),
                  // const SettingsTile(title: 'Terms of Service'),
                  SettingsTile(
                    title: 'Delete Account',
                    destructive: true,
                    onTap: () {
                      Get.to(() => DeleteAccountView());
                    },
                  ),
                  SettingsTile(
                    title: 'Logout',
                    destructive: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          title: 'تسجيل الخروج',
                          message: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                          confirmText: 'تسجيل الخروج',
                          cancelText: 'إلغاء',
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

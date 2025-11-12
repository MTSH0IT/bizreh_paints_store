import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/personalInformation/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Please enter your current and new password',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Obx(
                () => LabeledTextField(
                  label: 'Current Password',
                  hint: 'Enter current password',
                  controller: ctrl.currentPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.currentPasswordError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => LabeledTextField(
                  label: 'New Password',
                  hint: 'Enter new password',
                  controller: ctrl.newPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.newPasswordError.value,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Password must be at least 6 characters long',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Obx(
                () => MainButton(
                  title: ctrl.isLoding.value
                      ? 'Updating...'
                      : 'Update Password',
                  onPressed: ctrl.isLoding.value
                      ? null
                      : () async {
                          await ctrl.changePassword();
                          if (!ctrl.isLoding.value) {
                            ctrl.currentPasswordCtrl.clear();
                            ctrl.newPasswordCtrl.clear();
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

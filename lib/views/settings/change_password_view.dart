import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/labeled_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'settings.change_password'.tr(),
          style: const TextStyle(
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
              Text(
                'change_password.subtitle'.tr(),
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Obx(
                () => LabeledTextField(
                  label: 'change_password.current_password_label'.tr(),
                  hint: 'change_password.current_password_hint'.tr(),
                  controller: ctrl.currentPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.currentPasswordError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => LabeledTextField(
                  label: 'change_password.new_password_label'.tr(),
                  hint: 'change_password.new_password_hint'.tr(),
                  controller: ctrl.newPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.newPasswordError.value,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'change_password.password_rule'.tr(),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Obx(
                () => MainButton(
                  title: ctrl.isLoding.value
                      ? 'change_password.updating'.tr()
                      : 'change_password.update_button'.tr(),
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

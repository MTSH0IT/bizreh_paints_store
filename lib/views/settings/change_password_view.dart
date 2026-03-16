import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/labeled_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: Text(
          tr('settings.change_password'),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                tr('change_password.subtitle'),
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Obx(
                () => LabeledTextField(
                  label: tr('change_password.current_password_label'),
                  hint: tr('change_password.current_password_hint'),
                  controller: ctrl.currentPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.currentPasswordError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => LabeledTextField(
                  label: tr('change_password.new_password_label'),
                  hint: tr('change_password.new_password_hint'),
                  controller: ctrl.newPasswordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.newPasswordError.value,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr('change_password.password_rule'),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              Obx(
                () => MainButton(
                  title: ctrl.isLoding.value
                      ? tr('change_password.updating')
                      : tr('change_password.update_button'),
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

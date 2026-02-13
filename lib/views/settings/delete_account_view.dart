import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/labeled_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class DeleteAccountView extends StatelessWidget {
  DeleteAccountView({super.key});

  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'delete_account.title'.tr(),
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red[700],
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'delete_account.warning_title'.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'delete_account.warning_message'.tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'delete_account.subtitle'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => LabeledTextField(
                  label: 'delete_account.password_label'.tr(),
                  hint: 'delete_account.password_hint'.tr(),
                  controller: ctrl.passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.passwordError.value,
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => MainButton(
                  title: ctrl.isLoding.value
                      ? 'delete_account.deleting'.tr()
                      : 'delete_account.delete_button'.tr(),
                  onPressed: ctrl.isLoding.value
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: 'delete_account.dialog.title'.tr(),
                              message: 'delete_account.dialog.message'.tr(),
                              confirmText: 'delete_account.dialog.confirm'.tr(),
                              cancelText: 'delete_account.dialog.cancel'.tr(),
                              isDestructive: true,
                              onConfirm: () async {
                                await ctrl.deleteAccount();
                              },
                            ),
                          );
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

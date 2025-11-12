import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/personalInformation/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountView extends StatelessWidget {
  DeleteAccountView({super.key});

  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Delete Account',
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
                            'Warning',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Deleting your account is a final action. All your data will be permanently deleted.',
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
              const Text(
                'Please enter your password to confirm',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => LabeledTextField(
                  label: 'Password',
                  hint: 'Enter password to confirm',
                  controller: ctrl.passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  errorText: ctrl.passwordError.value,
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => MainButton(
                  title: ctrl.isLoding.value ? 'Deleting...' : 'Delete Account',
                  onPressed: ctrl.isLoding.value
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: 'Delete Account',
                              message:
                                  'Are you sure you want to delete your account? You will not be able to recover your data after this.',
                              confirmText: 'Delete Account',
                              cancelText: 'Cancel',
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

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/utils/func/input_validation.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthHeader(title: 'auth.sign_up.title'.tr()),
                      AuthTextField(
                        controller: auth.firstNameCtrl,
                        hint: 'auth.first_name'.tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'auth.first_name_required'.tr();
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: auth.lastNameCtrl,
                        hint: 'auth.last_name'.tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'auth.last_name_required'.tr();
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: auth.phoneCtrl,
                        hint: 'auth.phone'.tr(),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return validatePhoneNumber(value);
                        },
                      ),
                      AuthTextField(
                        controller: auth.emailCtrl,
                        hint: 'auth.email'.tr(),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return validateEmailAddress(
                            value,
                            requiredMessage: 'auth.email_required'.tr(),
                            invalidMessage: 'auth.email_invalid'.tr(),
                          );
                        },
                      ),
                      AuthTextField(
                        controller: auth.passwordCtrl,
                        hint: 'auth.password'.tr(),
                        obscure: true,
                        validator: (value) {
                          return validatePasswordValue(
                            value,
                            minLength: 6,
                            requiredMessage: 'auth.password_required'.tr(),
                            tooShortMessage: 'auth.password_short'.tr(),
                          );
                        },
                      ),
                      AuthTextField(
                        controller: auth.confirmCtrl,
                        hint: 'auth.confirm_password'.tr(),
                        obscure: true,
                        validator: (value) {
                          return validateConfirmPassword(
                            value,
                            auth.passwordCtrl.text,
                            requiredMessage: 'auth.confirm_password_required'
                                .tr(),
                            mismatchMessage: 'auth.password_mismatch'.tr(),
                          );
                        },
                      ),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: MainButton(
                          title: auth.isLoading.value
                              ? 'auth.please_wait'.tr()
                              : 'auth.sign_up.button'.tr(),
                          onPressed: auth.isLoading.value
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await auth.signUp();
                                  }
                                },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('auth.sign_up.have_account'.tr()),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'auth.sign_in.button'.tr(),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (auth.isLoading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black38,
                  child: const BuildProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

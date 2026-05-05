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
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(title: tr('auth.sign_up.title')),
                    AuthTextField(
                      controller: auth.firstNameCtrl,
                      hint: tr('auth.first_name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('auth.first_name_required');
                        }
                        return null;
                      },
                    ),
                    AuthTextField(
                      controller: auth.lastNameCtrl,
                      hint: tr('auth.last_name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('auth.last_name_required');
                        }
                        return null;
                      },
                    ),
                    AuthTextField(
                      controller: auth.phoneCtrl,
                      hint: tr('auth.phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        return validatePhoneNumber(value);
                      },
                    ),
                    AuthTextField(
                      controller: auth.emailCtrl,
                      hint: tr('auth.email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return validateEmailAddress(
                          value,
                          requiredMessage: tr('auth.email_required'),
                          invalidMessage: tr('auth.email_invalid'),
                        );
                      },
                    ),
                    AuthTextField(
                      controller: auth.passwordCtrl,
                      hint: tr('auth.password'),
                      obscure: true,
                      validator: (value) {
                        return validatePasswordValue(
                          value,
                          minLength: 6,
                          requiredMessage: tr('auth.password_required'),
                          tooShortMessage: tr('auth.password_short'),
                        );
                      },
                    ),
                    AuthTextField(
                      controller: auth.confirmCtrl,
                      hint: tr('auth.confirm_password'),
                      obscure: true,
                      validator: (value) {
                        return validateConfirmPassword(
                          value,
                          auth.passwordCtrl.text,
                          requiredMessage: tr(
                            'auth.confirm_password_required',
                          ),
                          mismatchMessage: tr('auth.password_mismatch'),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Obx(() => MainButton(
                            title: auth.isLoading.value
                                ? tr('auth.please_wait')
                                : tr('auth.sign_up.button'),
                            onPressed: auth.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      await auth.signUp();
                                    }
                                  },
                          )),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tr('auth.sign_up.have_account')),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              tr('auth.sign_in.button'),
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
          // Loading overlay — reacts only to isLoading
          Obx(() => auth.isLoading.value
              ? Positioned.fill(
                  child: Container(
                    color: Colors.black38,
                    child: const BuildProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

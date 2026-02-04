import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/func/input_validation.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:bizreh_paints_store/controllers/auth_controller.dart';

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
                      const AuthHeader(title: 'Create an account'),
                      AuthTextField(
                        controller: auth.firstNameCtrl,
                        hint: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: auth.lastNameCtrl,
                        hint: 'Last Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: auth.phoneCtrl,
                        hint: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return validatePhoneNumber(value);
                        },
                      ),
                      AuthTextField(
                        controller: auth.emailCtrl,
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return validateEmailAddress(
                            value,
                            requiredMessage: 'Please enter your email',
                            invalidMessage: 'Please enter a valid email',
                          );
                        },
                      ),
                      AuthTextField(
                        controller: auth.passwordCtrl,
                        hint: 'Password',
                        obscure: true,
                        validator: (value) {
                          return validatePasswordValue(
                            value,
                            minLength: 6,
                            requiredMessage: 'Please enter your password',
                            tooShortMessage:
                                'Password must be at least 6 characters',
                          );
                        },
                      ),
                      AuthTextField(
                        controller: auth.confirmCtrl,
                        hint: 'Confirm Password',
                        obscure: true,
                        validator: (value) {
                          return validateConfirmPassword(
                            value,
                            auth.passwordCtrl.text,
                            requiredMessage: 'Please confirm your password',
                            mismatchMessage: 'Passwords do not match',
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
                              ? 'الرجاء الانتظار...'
                              : 'Create Account',
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
                            const Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
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

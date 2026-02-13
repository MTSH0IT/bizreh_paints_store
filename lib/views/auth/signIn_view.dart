import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/auth/signUp_view.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/secondary_button.dart';
import 'package:bizreh_paints_store/views/auth/forgot_password_view.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    return Scaffold(
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthHeader(
                        title: 'auth.sign_in.title'.tr(),
                        subtitle: 'auth.sign_in.subtitle'.tr(),
                      ),
                      AuthTextField(
                        controller: auth.loginEmailCtrl,
                        hint: 'auth.email'.tr(),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'auth.email_required'.tr();
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'auth.email_invalid'.tr();
                          }
                          return null;
                        },
                      ),
                      AuthTextField(
                        controller: auth.loginPasswordCtrl,
                        hint: 'auth.password'.tr(),
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'auth.password_required'.tr();
                          }
                          if (value.length < 6) {
                            return 'auth.password_short'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 4),
                      AuthTextLink(
                        text: 'auth.forgot_password'.tr(),
                        onTap: () {
                          Get.to(() => ForgotPasswordView());
                        },
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MainButton(
                          title: auth.isLoading.value
                              ? 'auth.please_wait'.tr()
                              : 'auth.sign_in.button'.tr(),
                          onPressed: auth.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    auth.signIn();
                                  }
                                },
                        ),
                      ),
                      SecondaryButton(
                        title: 'auth.sign_in.new_user'.tr(),
                        onPressed: () {
                          Get.to(() => SignUpView());
                        },
                      ),
                      const SizedBox(height: 24),
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

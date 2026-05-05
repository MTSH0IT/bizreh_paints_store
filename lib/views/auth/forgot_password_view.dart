import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    return Scaffold(
      appBar: CommonAppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          tr('auth.forgot_password.title'),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
                    AuthHeader(
                      title: tr('auth.forgot_password.reset_title'),
                      subtitle: tr('auth.forgot_password.subtitle'),
                    ),
                    AuthTextField(
                      controller: auth.forgotPasswordEmailCtrl,
                      hint: tr('auth.email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('auth.email_required');
                        }
                        if (!GetUtils.isEmail(value)) {
                          return tr('auth.email_invalid');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(() => MainButton(
                            title: auth.isLoading.value
                                ? tr('auth.please_wait')
                                : tr('auth.forgot_password.send_button'),
                            onPressed: auth.isLoading.value
                                ? null
                                : () async {
                                    if (!(_formKey.currentState?.validate() ??
                                        false)) {
                                      return;
                                    }
                                    await auth.forgetPassword();
                                  },
                          )),
                    ),
                    const SizedBox(height: 24),
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

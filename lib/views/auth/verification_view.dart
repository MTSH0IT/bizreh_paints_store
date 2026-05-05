import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/otp_code_fields.dart';
import 'package:bizreh_paints_store/views/auth/widgets/verify_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String _code = '';

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
          tr('auth.verification.title'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthHeader(
                  title: tr('auth.verification.enter_code'),
                  subtitle: tr('auth.verification.subtitle'),
                ),
                Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: OtpCodeFields(
                    onCompleted: (v) => setState(() => _code = v),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    tr('auth.verification.no_code'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                AuthTextLink(
                  text: tr('auth.verification.resend'),
                  alignment: MainAxisAlignment.center,
                  onTap: () async {
                    await auth.resendVerification();
                  },
                ),
                const Spacer(),
                VerifyButton(
                  title: tr('auth.verification.verify'),
                  onPressed: _code.length == 6
                      ? () async {
                          await auth.verifyAccount(verificationCode: _code);
                        }
                      : null,
                ),
              ],
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

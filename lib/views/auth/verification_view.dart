import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/otp_code_fields.dart';
import 'package:bizreh_paints_store/views/auth/widgets/verify_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

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
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'auth.verification.title'.tr(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthHeader(
                    title: 'auth.verification.enter_code'.tr(),
                    subtitle: 'auth.verification.subtitle'.tr(),
                  ),
                  OtpCodeFields(onCompleted: (v) => setState(() => _code = v)),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'auth.verification.no_code'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  AuthTextLink(
                    text: 'auth.verification.resend'.tr(),
                    alignment: MainAxisAlignment.center,
                    onTap: () async {
                      await auth.resendVerification();
                    },
                  ),
                  const Spacer(),
                  VerifyButton(
                    title: 'auth.verification.verify'.tr(),
                    onPressed: _code.length == 6
                        ? () async {
                            await auth.verifyAccount(verificationCode: _code);
                          }
                        : null,
                  ),
                ],
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

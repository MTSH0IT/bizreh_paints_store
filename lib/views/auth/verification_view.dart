import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/otp_code_fields.dart';
import 'package:bizreh_paints_store/views/auth/widgets/verify_button.dart';
import 'package:get/get.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Verification',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Enter Your Code',
              subtitle:
                  'We sent a 6-digit verification code to your email address.',
            ),
            OtpCodeFields(onCompleted: (v) => setState(() => _code = v)),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Didn't receive the code?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            AuthTextLink(
              text: 'Resend Code',
              alignment: MainAxisAlignment.center,
              onTap: () {
                // TODO: trigger resend code action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resend code tapped')),
                );
              },
            ),
            const Spacer(),
            VerifyButton(
              title: 'Verify',
              onPressed: _code.length == 6
                  ? () {
                      // TODO: handle verify action with _code
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verifying: $_code')),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

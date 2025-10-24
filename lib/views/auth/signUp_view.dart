import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/auth/signIn_view.dart';
import 'package:bizreh_paints_store/views/auth/verification_view.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    phoneCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(title: 'Create an account'),
              AuthTextField(controller: firstNameCtrl, hint: 'First Name'),
              AuthTextField(controller: lastNameCtrl, hint: 'Last Name'),
              AuthTextField(
                controller: phoneCtrl,
                hint: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              AuthTextField(
                controller: emailCtrl,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              AuthTextField(
                controller: passCtrl,
                hint: 'Password',
                obscure: true,
              ),
              AuthTextField(
                controller: confirmCtrl,
                hint: 'Confirm Password',
                obscure: true,
              ),

              const SizedBox(height: 8),
              MainButton(
                title: 'Create Account',
                onPressed: () {
                  Get.to(() => const VerificationView());
                },
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
                        Get.to(() => const SignInView());
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/auth/signUp_view.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/secondary_button.dart';
import 'package:bizreh_paints_store/views/mainView/main_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
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
              const AuthHeader(
                title: 'Welcome back',
                subtitle: 'Please enter your details to sign in.',
              ),
              AuthTextField(
                controller: emailCtrl,
                hint: 'Email address',
                keyboardType: TextInputType.emailAddress,
              ),
              AuthTextField(
                controller: passCtrl,
                hint: 'Password',
                obscure: true,
              ),
              const SizedBox(height: 4),
              AuthTextLink(text: 'Forgot password?', onTap: () {}),
              const SizedBox(height: 8),
              MainButton(
                title: 'Log In',
                onPressed: () {
                  Get.offAll(() => MainView());
                },
              ),
              SecondaryButton(
                title: 'New User Sign Up',
                onPressed: () {
                  Get.to(() => const SignUpView());
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

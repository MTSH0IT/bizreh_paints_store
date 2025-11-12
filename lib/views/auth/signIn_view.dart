import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/auth/signUp_view.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_header.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_field.dart';
import 'package:bizreh_paints_store/views/auth/widgets/auth_text_link.dart';
import 'package:bizreh_paints_store/views/auth/widgets/secondary_button.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});
  final AuthController _auth = Get.put(AuthController());
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthHeader(
                  title: 'Welcome back',
                  subtitle: 'Please enter your details to sign in.',
                ),
                AuthTextField(
                  controller: widget._auth.loginEmailCtrl,
                  hint: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                AuthTextField(
                  controller: widget._auth.loginPasswordCtrl,
                  hint: 'Password',
                  obscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 4),
                AuthTextLink(text: 'Forgot password?', onTap: () {}),
                const SizedBox(height: 8),
                MainButton(
                  title: 'Log In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget._auth.signIn();
                    }
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
      ),
    );
  }
}

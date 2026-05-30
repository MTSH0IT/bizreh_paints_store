import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:bizreh_paints_store/views/auth/signIn_view.dart';
import 'package:bizreh_paints_store/views/mainView/main_view.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final auth = Get.find<AuthController>();
    final ok = await auth.tryAutoLogin();

    if (!mounted) return;
    if (ok) {
      Get.offAll(() => const MainView());
    } else {
      Get.offAll(() => SignInView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, backgroundColor],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

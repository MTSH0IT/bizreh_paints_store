import 'dart:developer';

import 'package:bizreh_paints_store/views/mainView/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/services/auth_services.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:bizreh_paints_store/models/auth_response.dart';

class AuthController extends GetxController {
  // Services
  final AuthService _authService = AuthService();
  final StorageService _storage = StorageService();

  // Form controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController loginEmailCtrl = TextEditingController();
  final TextEditingController loginPasswordCtrl = TextEditingController();

  // Reactive state
  final RxBool isLoading = false.obs;
  final RxBool isLoggingIn = false.obs;
  final RxBool isSigningUp = false.obs;
  final RxnString generalError = RxnString();

  String get email => emailCtrl.text.trim();
  String get password => passwordCtrl.text.trim();
  String get firstName => firstNameCtrl.text.trim();
  String get lastName => lastNameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();
  String get loginEmail => loginEmailCtrl.text.trim();
  String get loginPassword => loginPasswordCtrl.text.trim();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    loginEmailCtrl.dispose();
    loginPasswordCtrl.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      final AuthResponse res = await _authService.signin(
        email: loginEmail,
        password: loginPassword,
      );
      await _persistAuth(res);
      Get.offAll(() => MainView());
      Get.snackbar(
        'مرحبًا',
        'تم تسجيل الدخول بنجاح',
        snackPosition: SnackPosition.TOP,
      );
    } on AppException catch (e) {
      generalError.value = e.message;
      log("auth controller AppException sign in : ${generalError.value}");
      _showError(e.message);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch sign in : ${generalError.value}");
      _showError("حدث خطأ ما حاول مرة اخرى");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      final AuthResponse res = await _authService.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      await _persistAuth(res);
      Get.back(); // or navigate to home
      Get.snackbar(
        'مرحبًا',
        'تم إنشاء الحساب وتسجيل الدخول',
        snackPosition: SnackPosition.TOP,
      );
    } on AppException catch (e) {
      generalError.value = e.message;
      log("auth controller AppException sign up : ${generalError.value}");
      _showError(e.message);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch sign up : ${generalError.value}");
      _showError("حدث خطأ  حاول مرة اخرى");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    // TODO: implement signOut
  }

  Future<void> _persistAuth(AuthResponse res) async {
    log("persistAuth token:\n ${res.token}");
    await _storage.setString(StorageKey.accessToken, res.token);

    log("persistAuth user:\n ${res.user.toString()}");
    await _storage.setJson(StorageKey.user, res.user.toJson());
  }

  void _showError(String message) {
    Get.snackbar(
      'خطأ',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFB00020),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

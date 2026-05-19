import 'dart:developer';

import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:bizreh_paints_store/views/auth/signIn_view.dart';
import 'package:bizreh_paints_store/views/auth/verification_view.dart';
import 'package:bizreh_paints_store/views/mainView/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/services/auth_services.dart';
import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:bizreh_paints_store/models/auth_response.dart';
import 'package:bizreh_paints_store/helper/di/token_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthController extends GetxController {
  // Services
  final AuthService _authService;
  final StorageService _storage;
  final ITokenProvider _tokenProvider;

  AuthController({
    required AuthService authService,
    required StorageService storageService,
    required ITokenProvider tokenProvider,
  }) : _authService = authService,
       _storage = storageService,
       _tokenProvider = tokenProvider;

  static String? token;

  // Form controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController loginEmailCtrl = TextEditingController();
  final TextEditingController loginPasswordCtrl = TextEditingController();
  final TextEditingController forgotPasswordEmailCtrl = TextEditingController();

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
  String get forgotPasswordEmail => forgotPasswordEmailCtrl.text.trim();

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
    forgotPasswordEmailCtrl.dispose();
    super.onClose();
  }

  void clearCtrl() {
    emailCtrl.clear();
    passwordCtrl.clear();
    confirmCtrl.clear();
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    phoneCtrl.clear();
    loginEmailCtrl.clear();
    loginPasswordCtrl.clear();
    forgotPasswordEmailCtrl.clear();
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      final AuthResponse res = await _authService.signin(
        email: loginEmail,
        password: loginPassword,
      );
      await _persistAuth(res);
      await _storage.setString(StorageKey.email, loginEmail);
      await _storage.setString(StorageKey.password, loginPassword);
      Get.offAll(() => MainView());
      clearCtrl();
    } on AppException catch (e) {
      generalError.value = e.message;
      log("auth controller AppException sign in : ${generalError.value}");
      showMassage(e.message, false);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch sign in : ${generalError.value}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> tryAutoLogin() async {
    isLoading.value = true;
    try {
      final savedEmail = _storage.getString(StorageKey.email);
      final savedPassword = _storage.getString(StorageKey.password);

      if (savedEmail == null || savedEmail.isEmpty) return false;
      if (savedPassword == null || savedPassword.isEmpty) return false;

      final AuthResponse res = await _authService.signin(
        email: savedEmail,
        password: savedPassword,
      );
      await _persistAuth(res);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      await _authService.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      Get.to(() => VerificationView());
    } on AppException catch (e) {
      generalError.value = e.message;
      log("auth controller AppException sign up : ${generalError.value}");
      showMassage(e.message, false);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch sign up : ${generalError.value}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgetPassword() async {
    isLoading.value = true;
    try {
      final msg = await _authService.forgetPassword(email: forgotPasswordEmail);
      showMassage(msg, true);
    } on AppException catch (e) {
      generalError.value = e.message;
      log(
        "auth controller AppException forget password : ${generalError.value}",
      );
      showMassage(e.message, false);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch forget password : ${generalError.value}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendVerification() async {
    isLoading.value = true;
    try {
      final msg = await _authService.resendVerification(email: email);
      showMassage(msg, true);
    } on AppException catch (e) {
      generalError.value = e.message;
      log(
        "auth controller AppException resend verification : ${generalError.value}",
      );
      showMassage(e.message, false);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch resend verification : ${generalError.value}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyAccount({required String verificationCode}) async {
    isLoading.value = true;
    try {
      final msg = await _authService.verifyAccount(
        email: email,
        verificationCode: verificationCode.trim(),
      );
      showMassage(msg, true);
      Get.offAll(() => SignInView());
    } on AppException catch (e) {
      generalError.value = e.message;
      log(
        "auth controller AppException verify account : ${generalError.value}",
      );
      showMassage(e.message, false);
    } catch (e) {
      generalError.value = e.toString();
      log("auth controller catch verify account : ${generalError.value}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _persistAuth(AuthResponse res) async {
    log("persistAuth token:\n ${res.token}");
    token = res.token;
    await _tokenProvider.setToken(res.token);

    log("persistAuth user:\n ${res.user.toString()}");
    await _storage.setJson(StorageKey.user, res.user.toJson());
  }
}

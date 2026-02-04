import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/services/user_services.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';
import 'package:bizreh_paints_store/utils/func/get_user.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:bizreh_paints_store/utils/func/input_validation.dart';
import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:bizreh_paints_store/views/auth/signIn_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalController extends GetxController {
  final UserService _userService = UserService();
  final StorageService _storage = StorageService();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController currentPasswordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final RxnString firstNameError = RxnString();
  final RxnString lastNameError = RxnString();
  final RxnString emailError = RxnString();
  final RxnString phoneError = RxnString();
  final RxnString currentPasswordError = RxnString();
  final RxnString newPasswordError = RxnString();
  final RxnString passwordError = RxnString();

  String get firstName => firstNameCtrl.text.trim();
  String get lastName => lastNameCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();
  String get currentPassword => currentPasswordCtrl.text.trim();
  String get newPassword => newPasswordCtrl.text.trim();
  String get password => passwordCtrl.text.trim();

  final RxBool isLoding = false.obs;
  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  void _loadUserData() async {
    final user = await getUser();
    firstNameCtrl.text = user.firstName;
    lastNameCtrl.text = user.lastName;
    emailCtrl.text = user.email;
    phoneCtrl.text = user.phone;
  }

  bool _validateFirstName() {
    if (firstName.isEmpty) {
      firstNameError.value = 'First name is required';
      return false;
    }
    firstNameError.value = null;
    return true;
  }

  bool _validateLastName() {
    if (lastName.isEmpty) {
      lastNameError.value = 'Last name is required';
      return false;
    }
    lastNameError.value = null;
    return true;
  }

  bool _validateEmail() {
    final error = validateEmailAddress(email);
    emailError.value = error;
    return error == null;
  }

  bool _validatePhone() {
    final error = validatePhoneNumber(phone);
    phoneError.value = error;
    return error == null;
  }

  bool _validatePassword(String password, RxnString errorVariable) {
    final error = validatePasswordValue(password, minLength: 6);
    errorVariable.value = error;
    return error == null;
  }

  bool validateAll() {
    final okFirstName = _validateFirstName();
    final okLastName = _validateLastName();
    final okEmail = _validateEmail();
    final okPhone = _validatePhone();
    return okFirstName && okLastName && okEmail && okPhone;
  }

  Future<void> changeInfo() async {
    if (!validateAll()) {
      return;
    }
    isLoding.value = true;
    try {
      await _userService.updateProfail(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );

      showMassage("تم تحديث البيانات", true);
      final user = await _userService.getProfile();
      log("personal controller get profile : ${user.toString()}");
      await _storage.setJson(StorageKey.user, user.toJson());
    } on AppException catch (e) {
      log("personal controller AppException sign up : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("personal controller catch sign up : ${e.toString()}");
      showMassage("حدث خطأ  حاول مرة اخرى", false);
    } finally {
      isLoding.value = false;
    }
  }

  Future<void> signOut() async {
    await _storage.remove(StorageKey.token);
    await _storage.remove(StorageKey.user);
    await _storage.clear();
    Get.offAll(() => SignInView());
  }

  Future<void> changePassword() async {
    if (!_validatePassword(currentPassword, currentPasswordError) ||
        !_validatePassword(newPassword, newPasswordError)) {
      return;
    }
    isLoding.value = true;
    try {
      await _userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      showMassage("تم تحديث البيانات", true);
    } on AppException catch (e) {
      log("personal controller AppException sign up : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("personal controller catch sign up : ${e.toString()}");
      showMassage("حدث خطأ  حاول مرة اخرى", false);
    } finally {
      isLoding.value = false;
    }
  }

  Future<void> deleteAccount() async {
    if (!_validatePassword(password, passwordError)) {
      return;
    }
    isLoding.value = true;
    try {
      await _userService.deleteAccount(password: password);
      showMassage("تم حذف حساب المستخدم", true);
      signOut();
    } on AppException catch (e) {
      log("personal controller AppException Delete Account : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("personal controller catch Delete Account : ${e.toString()}");
      showMassage("حدث خطأ  حاول مرة اخرى", false);
    } finally {
      isLoding.value = false;
    }
  }
}

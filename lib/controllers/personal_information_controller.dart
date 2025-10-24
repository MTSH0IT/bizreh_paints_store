import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformationController extends GetxController {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final RxnString nameError = RxnString();
  final RxnString emailError = RxnString();
  final RxnString phoneError = RxnString();

  final RxBool isSaving = false.obs;

  String get name => nameCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }

  bool _validateName() {
    if (name.isEmpty) {
      nameError.value = 'Name is required';
      return false;
    }
    nameError.value = null;
    return true;
  }

  bool _validateEmail() {
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Enter a valid email';
      return false;
    }
    emailError.value = null;
    return true;
  }

  bool _validatePhone() {
    if (phone.isEmpty) {
      phoneError.value = 'Phone is required';
      return false;
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      phoneError.value = 'Enter a valid phone number';
      return false;
    }
    phoneError.value = null;
    return true;
  }

  bool validateAll() {
    final okName = _validateName();
    final okEmail = _validateEmail();
    final okPhone = _validatePhone();
    return okName && okEmail && okPhone;
  }

  Future<void> changeInfo() async {
    if (!validateAll()) return;
    //TODO: change info
  }
}

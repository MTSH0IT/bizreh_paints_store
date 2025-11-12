import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMassage(String message, bool success) {
  Get.snackbar(
    success ? 'نجاح' : 'خطأ',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: success ? Colors.green : Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

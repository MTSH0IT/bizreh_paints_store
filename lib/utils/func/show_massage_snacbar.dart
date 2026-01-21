import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMassage(String message, bool success) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Get.rawSnackbar(
    //   title: success ? 'نجاح' : 'خطأ',
    //   message: message,
    //   backgroundColor: success ? Colors.green : Colors.red,
    //   snackPosition: SnackPosition.TOP,
    //   icon: Icon(
    //     success ? Icons.check_circle : Icons.error_outline,
    //     color: Colors.white,
    //   ),
    //   duration: const Duration(seconds: 3),
    // );
  });
}

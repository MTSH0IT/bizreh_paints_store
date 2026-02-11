// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

// void showMassage(String message, bool success) {
//   _showAwesomeBanner(Get.key.currentContext!, message, success);
// }

// void _showAwesomeBanner(BuildContext? context, String message, bool success) {
//   ScaffoldMessenger.of(context!).showSnackBar(
//     SnackBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       behavior: SnackBarBehavior.floating,
//       content: AwesomeSnackbarContent(
//         title: success ? 'نجاح' : 'خطأ',
//         message: message,
//         contentType: success ? ContentType.success : ContentType.failure,
//       ),
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMassage(String message, bool success) {
  Get.showSnackbar(
    GetSnackBar(
      title: success ? 'نجاح' : 'خطأ',
      message: message,
      backgroundColor: success ? Colors.green : Colors.red,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      isDismissible: true,
      duration: success
          ? const Duration(seconds: 1)
          : const Duration(seconds: 3),
      icon: Icon(
        success ? Icons.check_circle : Icons.error_outline,
        color: Colors.white,
      ),
    ),
  );
}

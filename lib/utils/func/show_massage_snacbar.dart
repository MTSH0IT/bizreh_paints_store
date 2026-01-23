import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showMassage(String message, bool success) {
  final context = Get.key.currentContext;
  if (context == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postFrameContext = Get.key.currentContext;
      if (postFrameContext != null) {
        _showSnackbar(postFrameContext, message, success);
      }
    });
    return;
  }
  _showSnackbar(context, message, success);
}

void _showSnackbar(BuildContext context, String message, bool success) {
  // الكود القديم باستخدام awesome_snackbar_content
  // final materialBanner = MaterialBanner(
  //   elevation: 0,
  //   backgroundColor: Colors.transparent,
  //   forceActionsBelow: true,
  //   content: AwesomeSnackbarContent(
  //     title: success ? 'نجاح' : 'خطأ',
  //     message: message,
  //     contentType: success ? ContentType.success : ContentType.failure,
  //     inMaterialBanner: true,
  //   ),
  //   actions: const [SizedBox()],
  // );
  //
  // ScaffoldMessenger.of(context)
  //   ..hideCurrentMaterialBanner()
  //   ..showMaterialBanner(materialBanner);
  //
  // // إخفاء الـ banner تلقائياً بعد 3 ثواني
  // Future.delayed(const Duration(seconds: 3), () {
  //   ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  // });

  // استخدام MaterialBanner من Flutter الأصلي للظهور في الأعلى
  final materialBanner = MaterialBanner(
    content: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error_outline,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                success ? 'نجاح' : 'خطأ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(message, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: success ? Colors.green : Colors.red,
    actions: [
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: const Text('إخفاء', style: TextStyle(color: Colors.white)),
      ),
    ],
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);

  // إخفاء الـ banner تلقائياً بعد 3 ثواني
  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  });
}

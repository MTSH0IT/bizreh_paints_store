import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showMassage(String message, bool success) {
  //   final context = Get.key.currentContext;
  //   if (context == null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       final postFrameContext = Get.key.currentContext;
  //       if (postFrameContext != null) {
  //         _showTopSnackbar(postFrameContext, message, success);
  //       }
  //     });
  //     return;
  //   }
  //   _showTopSnackbar(context, message, success);
  // }

  // void _showTopSnackbar(BuildContext context, String message, bool success) {
  //   final overlay = Overlay.maybeOf(context, rootOverlay: true);
  //   if (overlay == null) return;

  //   showTopSnackBar(
  //     overlay,
  //     success
  //         ? CustomSnackBar.success(
  //             message: message,
  //             backgroundColor: const Color(0xFF16A34A),
  //             textStyle: const TextStyle(color: Colors.white, fontSize: 16),
  //             icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  //           )
  //         : CustomSnackBar.error(
  //             message: message,
  //             backgroundColor: const Color(0xFFDC2626),
  //             textStyle: const TextStyle(color: Colors.white, fontSize: 16),
  //             icon: const Icon(
  //               Icons.error_outline,
  //               color: Colors.white,
  //               size: 40,
  //             ),
  //           ),
  //   );
  // }

  // الكود القديم باستخدام GetX SnackBar
  // void showMassage(String message, bool success) {
  //   Future.delayed(const Duration(milliseconds: 600), () {
  //     if (!Get.isSnackbarOpen) {
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           title: success ? 'نجاح' : 'خطأ',
  //           message: message,
  //           snackPosition: SnackPosition.TOP,
  //           snackStyle: SnackStyle.FLOATING,
  //           backgroundColor: success
  //               ? const Color(0xFF16A34A)
  //               : const Color(0xFFDC2626),
  //           borderRadius: 16,
  //           margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
  //           maxWidth: 520,
  //           isDismissible: true,
  //           duration: const Duration(seconds: 2),
  //           animationDuration: const Duration(milliseconds: 300),
  //           icon: Icon(
  //             success ? Icons.check_circle : Icons.error_outline,
  //             color: Colors.white,
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }

  // الكود القديم باستخدام awesome_snackbar_content
  // void _showSnackbar(BuildContext context, String message, bool success) {
  //   final materialBanner = MaterialBanner(
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     forceActionsBelow: true,
  //     content: AwesomeSnackbarContent(
  //       title: success ? 'نجاح' : 'خطأ',
  //       message: message,
  //       contentType: success ? ContentType.success : ContentType.failure,
  //       inMaterialBanner: true,
  //     ),
  //     actions: const [SizedBox()],
  //   );
  //
  //   ScaffoldMessenger.of(context)
  //     ..hideCurrentMaterialBanner()
  //     ..showMaterialBanner(materialBanner);
  //
  //   // إخفاء الـ banner تلقائياً بعد 3 ثواني
  //   Future.delayed(const Duration(seconds: 3), () {
  //     ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //   });
  // }

  // الكود القديم باستخدام MaterialBanner مخصص
  void showSnackbar(BuildContext context, String message, bool success) {
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
}

import 'dart:developer';

import 'package:bizreh_paints_store/services/version_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionController extends GetxController {
  final VersionService _versionService;

  VersionController({required VersionService versionService})
    : _versionService = versionService;

  final RxBool isLoading = false.obs;
  final RxBool needsUpdate = false.obs;
  final RxString minVersion = ''.obs;

  Future<bool> checkVersion() async {
    isLoading.value = true;
    try {
      final minVer = await _versionService.getMinVersion();
      minVersion.value = minVer;

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      log('*******************************************');
      log('Current version: $currentVersion');
      log('Minimum required version: $minVer');

      final needsUpdate = _compareVersions(currentVersion, minVer) < 0;
      this.needsUpdate.value = needsUpdate;

      return needsUpdate;
    } catch (e) {
      log('Error checking version: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  int _compareVersions(String current, String minimum) {
    final currentParts = current.split('.').map(int.parse).toList();
    final minimumParts = minimum.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      final current = i < currentParts.length ? currentParts[i] : 0;
      final minimum = i < minimumParts.length ? minimumParts[i] : 0;

      if (current < minimum) return -1;
      if (current > minimum) return 1;
    }

    return 0;
  }

  void showForceUpdateDialog() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: Row(
            children: [
              Icon(Icons.system_update, color: Colors.orange, size: 28),
              SizedBox(width: 12),
              Text(
                'version.update_required'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('version.update_message'.tr(), style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
              Text(
                '${'version.current_version'.tr()}: ${minVersion.value}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _openStore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'version.update_now'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _openStore() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (GetPlatform.isAndroid) {
      final url =
          'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } else if (GetPlatform.isIOS) {
      final url = 'https://apps.apple.com/app/id${packageInfo.packageName}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    }
  }
}

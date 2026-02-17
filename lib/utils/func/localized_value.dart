import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

extension LocalizedValueX on BuildContext {
  bool get isArabic => locale.languageCode.toLowerCase() == 'ar';

  String localizedValue({
    required String? en,
    required String? ar,
    String fallback = '',
  }) {
    final primary = isArabic ? ar : en;
    final secondary = isArabic ? en : ar;

    final primaryTrimmed = primary?.trim();
    if (primaryTrimmed != null && primaryTrimmed.isNotEmpty) {
      return primaryTrimmed;
    }

    final secondaryTrimmed = secondary?.trim();
    if (secondaryTrimmed != null && secondaryTrimmed.isNotEmpty) {
      return secondaryTrimmed;
    }

    return fallback;
  }
}

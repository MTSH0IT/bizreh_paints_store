import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class AuthTextLink extends StatelessWidget {
  const AuthTextLink({
    super.key,
    required this.text,
    this.onTap,
    this.alignment = MainAxisAlignment.end,
  });

  final String text;
  final VoidCallback? onTap;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final link = GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: link,
    );
  }
}

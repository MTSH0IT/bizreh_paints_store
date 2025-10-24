import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool destructive;

  const SettingsTile({
    super.key,
    required this.title,
    this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: destructive ? Colors.deepOrange : Colors.black,
      fontWeight: FontWeight.w500,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 1,
      color: CardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: textStyle),
        trailing: Icon(
          Icons.chevron_right,
          color: destructive ? Colors.deepOrangeAccent : Colors.grey,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final ImageProvider? avatar;
  final VoidCallback? onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    this.avatar,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundImage: avatar,
              backgroundColor: Colors.grey[200],
              child: avatar == null
                  ? Icon(Icons.person, size: 50, color: primaryColor)
                  : null,
            ),
            InkWell(
              onTap: onEdit,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.edit, color: Colors.black, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

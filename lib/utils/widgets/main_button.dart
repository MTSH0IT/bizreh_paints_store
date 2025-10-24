import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, this.onPressed, this.title = 'Add to Cart'});

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
          ),
          onPressed: onPressed,
          child: Text(title, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    required this.color,
    required this.selected,
    this.width = 30,
    this.height = 30,
  });

  final Color color;
  final bool selected;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final iconColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? primaryColor : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: selected
            ? Center(
                child: Icon(
                  Icons.check,
                  size: (width - 12) > 10 ? (width - 12) : 10,
                  color: iconColor,
                ),
              )
            : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentPage;

  const StepIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    const titles = ['Phon', 'Address', 'Enroute'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الخط الرمادي الكامل
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(height: 2, color: Colors.grey[300]),
                  ),
                ),
                // الجزء الملوّن من الخط حتى الخطوة الحالية
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: currentPage == 0
                          ? 0.0
                          : currentPage == 1
                          ? 0.5
                          : 1.0,
                      child: Container(height: 2, color: primaryColor),
                    ),
                  ),
                ),
                // النقاط الثلاث فوق الخط
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    final isActive = index == currentPage;
                    final isCompleted = index < currentPage;
                    final bool filled = isActive || isCompleted;

                    return Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: filled ? primaryColor : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final isActive = index == currentPage;
              return Expanded(
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? primaryColor : Colors.grey[500],
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentPage;

  const StepIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    const titles = ['الهاتف', 'العنوان', 'التأكيد'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(3, (index) {
              final isActive = index == currentPage;
              final isCompleted = index < currentPage;
              final bool showRightLine = index < 2;

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        // نقطة الخطوة
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: (isActive || isCompleted)
                                ? primaryColor
                                : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: (isActive || isCompleted)
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // الخط الذي يمتد من يمين الدائرة
                        if (showRightLine)
                          Expanded(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 8,
                              ),
                              height: 2,
                              color: (isCompleted)
                                  ? primaryColor
                                  : Colors.grey[300],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? primaryColor : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
